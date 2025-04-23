import '../models/evento_drive_model.dart';

class PreviousEventDrive {

  static final enClave2 = EventoDrive(
    tituloTxtUrl: "https://drive.google.com/file/d/1Icn93g5o6OuUkIIo1dKL29CLVPKSHS4D/view?usp=drive_link",
    descripcionTxtUrl: "https://drive.google.com/file/d/1PNXw8vTMlgvcE_NJ0XxBm0ouEu_0FQ0g/view?usp=drive_link",
    imagenUrl: "https://drive.google.com/file/d/1CwrKcMO-k7ayXHXKFVVQycTcGbbHxi7w/view?usp=drive_link",
    programaUrl: "https://drive.google.com/file/d/1KvKTq4SwCezD11xmECtoZ_656sHANF5N/view?usp=drive_link",
  );

  static final faurePoulenc = EventoDrive(
    tituloTxtUrl: "https://drive.google.com/file/d/1yyzB6mPDhq2P5csGgyGI4dxpYFCUrhbq/view?usp=drive_link",
    descripcionTxtUrl: "https://drive.google.com/file/d/1V4bnICpaQwGQ9K81sDTsTnWuc4U7H4nM/view?usp=drive_link",
    imagenUrl: "https://drive.google.com/file/d/1eZPK-qNnZluGEzC4N0IMnjGLbQgUJn7p/view?usp=drive_link",
    programaUrl: "https://drive.google.com/file/d/1WEinevPy_WrH0mibHwXnGV7vF1e97S1X/view?usp=drive_link",
  );

  static final List<EventoDrive> todos = [
    enClave2,
    faurePoulenc,
  ];
}