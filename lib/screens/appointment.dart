import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../services/services.dart';
import '../themes/appTheme.dart';
import '../widgets/widgets.dart';
import '../providers/providers.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  bool data = false;
  bool _sliderEnable = false;
  TextEditingController id        = TextEditingController();
  TextEditingController name      = TextEditingController();
  TextEditingController note      = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();



  @override
  void initState() {
    super.initState();
    id.text        = "";
    name.text      = "";
    note.text      = "";
    dateInput.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    timeInput.text = DateFormat('hh:mm a').format(DateTime.now());
  }

  final _screenshotController = ScreenshotController(); 

  @override
  Widget build(BuildContext context) {
  
  final appointmentService = Provider.of<AppointmentService>(context);
  final appointmentData = Provider.of<AppointmentProvider>(context);
       

  
  final size = MediaQuery.of(context).size;

return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
      width: size.width*0.9,
      height: double.infinity,
      child: Form(
        key: appointmentData.formKey,
        autovalidateMode:AutovalidateMode.onUserInteraction, 
        child: Stack(

          children: [
              
            //textField para el nombre del visitante
            _visitor(size: size, appointmentData: appointmentData, name:name),

            //Aqui se ingresa la identidad
            _ID(size: size, appointmentData: appointmentData, id: id),

            //Aqui se da la opcion de ingresar una nota en caso que el usuario lo requiera
            const Positioned(
              width: 50,
              top: 45,
              right: 49,
              child: Text("nota")),

            Positioned(
              width: 150,
              top: 25,
              right: 0,
              child: SwitchListTile.adaptive(activeColor:AppTheme.primary, value: _sliderEnable, onChanged: (value){
                   setState(() {_sliderEnable = value;});
                   }),
            ),


            if (_sliderEnable)
              _note(size: size, note: note, appointmentData: appointmentData),


            //Aqui se selecciona la fecha
            Positioned(
                    width: 165,
                    top: _sliderEnable?310:220,
                    left: 20,
                    child: CustomTextField(
                      BorderSide: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))), 
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: AppTheme.primary), 
                        borderRadius: BorderRadius.circular(20)),
                      controller: dateInput,
                      keyboardType: TextInputType.none,
                      prefixIcon: Icons.date_range_outlined,
                      onChange: (value){},
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101));
            
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                          dateInput.text = formattedDate;
                          setState(() {});
                        }
                      },
                    ),
                  ),


               //Aqui se selecciona la hora
               Positioned(
                   width: 165,
                   top: _sliderEnable?310:220,
                   left: 200,
                   child: CustomTextField(
                    BorderSide: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))), 
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppTheme.primary), 
                      borderRadius: BorderRadius.circular(20)),
                    controller: timeInput,
                    keyboardType: TextInputType.none,
                    prefixIcon: Icons.timer_outlined,
                    onTap: () async {
                      final TimeOfDay? dayTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());            
                      if (dayTime != null) {
                        // ignore: use_build_context_synchronously
                        timeInput.text = dayTime.format(context); 
                        setState(() {});
                      }
                     },
                   ),
                 ),

                //Aqui se envian los datos al presionar el boton
                Positioned(
                  top: _sliderEnable?310:222.5,
                  right: 0,
                  child: ElevatedButton(onPressed: () async{
                    if (!appointmentData.isValidForm()) return;
                    appointmentData.date = dateInput.text;
                    appointmentData.hour = timeInput.text;
                    dynamic data = await appointmentService.createAppointment(appointmentData.message());


                    dynamic appointmenst= await appointmentService.getAppointments();
                    Map <String, dynamic> citas={};
                    for (var element in appointmenst) { 
                      if (element.date == dateInput.text){
                        citas = element.toMap();
                        }
                      } 
                    
                    print(citas.length);
                    
                    showDialog(
                      context: context, 
                      builder: (context)=> AlertDialog(
                        actions: [   
                        TextButton(onPressed: () async{
                            await _screenshotController.capture().then((bytes)async{
                            final Directory output= await getTemporaryDirectory();
                            final String screenshotFilePath = '${output.path}/image.png';
                            final File screenshortFile = File(screenshotFilePath);
                            await screenshortFile.writeAsBytes(bytes!);
                            Share.shareFiles([screenshotFilePath],
                            text: "test", 
                            sharePositionOrigin: (){RenderBox? box = context.findRenderObject() as RenderBox?; return box!.localToGlobal(Offset.zero)& box.size;}()).catchError((onError){print(onError);});
                          });

                          },
                        child: const Text("compartir")),
                        
                        TextButton(onPressed: (){
                          Navigator.of(context).pop();
                          note.text = "";
                          id.text   = "";
                          name.text = "";
                          },
                        child: const Text("close"))
                        ],

                        title: const Text("Visita agendada exitosamente"),
                        contentPadding: const EdgeInsets.all(20),
                        content: Screenshot(controller: _screenshotController,
                          child: Container(
                            height: 300,
                            width: 300,
                            color: Colors.white70,
                            child: QrImage(data: data.toString(), version: QrVersions.auto),
                            ),
                        ),                        
                      ));                    
                  }, child:const Text("Generar"))
              ),
              Positioned(
                top: _sliderEnable?400:310,
                left: 20,
                child: SingleChildScrollView(
                  child:SizedBox(
                    height: 300,
                    width: size.width*0.9,
                    child: Column( 
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       

                
                        ],
                      ),
                    )
                  )
                )


          ],
        ), 
       ),
     )
    ),
   );
  }
}

class _note extends StatelessWidget {
  const _note({
    Key? key,
    required this.size,
    required this.note,
    required this.appointmentData,
  }) : super(key: key);

  final Size size;
  final TextEditingController note;
  final AppointmentProvider appointmentData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: size.width*0.85,
      left: 20,
      top: 220,
      child: CustomTextField(
      BorderSide: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))), 
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppTheme.primary), 
        borderRadius: BorderRadius.circular(20)),
      hintText: "nota",
      autocorrect: false,
      controller: note, 
      prefixIcon: Icons.note_alt_outlined, 
      onChange: (value) {appointmentData.note = value;}
      ),
    );
  }
}

class _ID extends StatelessWidget {
  const _ID({
    Key? key,
    required this.size,
    required this.appointmentData,
    required this.id,
  }) : super(key: key);

  final Size size;
  final AppointmentProvider appointmentData;
  final TextEditingController id;

  @override
  Widget build(BuildContext context) {
    return Positioned(
     width: size.width*0.65,
     top: 120,
     left: 20,
     child: CustomTextField(
       BorderSide: const OutlineInputBorder(
         borderRadius: BorderRadius.all(Radius.circular(20))), 
       focusedBorder: OutlineInputBorder(
         borderSide: const BorderSide(color: AppTheme.primary), 
         borderRadius: BorderRadius.circular(20)),
       hintText: "Identidad",
       helperText: "*requerido",
       keyboardType: TextInputType.number, 
       prefixIcon: Icons.chrome_reader_mode_rounded,
       onChange: (value) {appointmentData.id = value;},
       controller: id,
       validator: (value){
         String pattern = r'^((([0-9]{4})+[-]){1,2})+[0-9]{5}$';
         RegExp regExp  = RegExp(pattern);
      
         return regExp.hasMatch(value ?? '')? null : "Identidad no valida";
       },
     ),
            );
  }
}

class _visitor extends StatelessWidget {

  const _visitor({
    Key? key,
    required this.size,
    required this.appointmentData,
    required this.name
  }) : super(key: key);

  final TextEditingController name;
  final Size size;
  final AppointmentProvider appointmentData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: size.width*0.65,
      top: 25,
      left: 20,
      child: CustomTextField(
        BorderSide: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))), 
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.primary), 
          borderRadius: BorderRadius.circular(20)),
        hintText: "Quien te visita",
        helperText: "*requerido",
        controller: name, 
        prefixIcon: Icons.person_outline,
        onChange: (value) {appointmentData.visitor = value;},
       
        validator: (value){
          String pattern = r"^[\w'\-,.][^0-9_!¡?÷?¿/\\+=@#$%ˆ&*(){}|~<>;:[\]]{2,}$";
          //String pattern = r'^(([A-Z]{1}[a-z]+[ ]*){1,2})$';
          RegExp regExp  = RegExp(pattern);
      
          return regExp.hasMatch(value ?? '')? null : "Nombre no valido";
        },
      ),
    );
  }
}

