import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mantencion/Drawer/buttondrawer.dart';
import 'package:mantencion/Drawer/cardswitchdrawer.dart';
import 'package:mantencion/Model/maquina.dart';
import 'package:mantencion/View/detalle_maquina.dart';
import 'package:mantencion/View/lecturapanel.dart';
import 'package:mantencion/constantes/colorgenerico.dart';
import 'package:mantencion/constantes/constantes.dart';
import 'package:mantencion/constantes/tipocambio.dart';

class NuevaMantencion extends StatefulWidget {
  final Maquina maquina;
  const NuevaMantencion({Key? key, required this.maquina}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NuevaMantencionState();
}

class NuevaMantencionState extends State<NuevaMantencion> {
  TextEditingController controllerNombreMaquina = TextEditingController();
  GlobalKey<FormState> keyFormMantencion = GlobalKey<FormState>();
  bool aceiteMotor = false;
  bool aceitehidra = false;
  bool aceitetransmicion = false;
  bool decantadoragua = false;
  bool filtroMotor = false;
  bool filtroHidra = false;
  bool faireexterno = false;
  bool faireinterno = false;
  bool elementofaire = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorGenerico.fondopagina,
        appBar: AppBar(
          title: const Text(
            tituloNuevaMantencion,
            style: TextStyle(color: ColorGenerico.titulopagina),
          ),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: ColorGenerico.fondopagina,
        ),
        body: Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width - 10,
              child: ListView(
                children: <Widget>[
                  CardSwitchDrawer(
                      titulo: TipoCambio.aceiteMotor,
                      subtitulo: '',
                      switchBool: aceiteMotor,
                      onSetState: (value) {
                        setState(() {
                          aceiteMotor = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.aceiteHidraulico,
                      subtitulo: '',
                      switchBool: aceitehidra,
                      onSetState: (value) {
                        setState(() {
                          aceitehidra = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.aceiteTransmision,
                      subtitulo: '',
                      switchBool: aceitetransmicion,
                      onSetState: (value) {
                        setState(() {
                          aceitetransmicion = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.decantadorAgua,
                      subtitulo: '',
                      switchBool: decantadoragua,
                      onSetState: (value) {
                        setState(() {
                          decantadoragua = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.elementoFiltroAire,
                      subtitulo: '',
                      switchBool: elementofaire,
                      onSetState: (value) {
                        setState(() {
                          elementofaire = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.filtroAceiteHidra,
                      subtitulo: '',
                      switchBool: filtroHidra,
                      onSetState: (value) {
                        setState(() {
                          filtroHidra = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.filtroAceiteMotor,
                      subtitulo: '',
                      switchBool: filtroMotor,
                      onSetState: (value) {
                        setState(() {
                          filtroMotor = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.filtroAireExterno,
                      subtitulo: '',
                      switchBool: faireexterno,
                      onSetState: (value) {
                        setState(() {
                          faireexterno = value;
                        });
                      }),
                  CardSwitchDrawer(
                      titulo: TipoCambio.filtroAireInterno,
                      subtitulo: '',
                      switchBool: faireinterno,
                      onSetState: (value) {
                        setState(() {
                          faireinterno = value;
                        });
                      }),
                  const SizedBox(height: 20),
                  Row(children: <Widget>[
                    Flexible(
                        child: ButtonDrawer(
                      color: Colors.red,
                      titulo: etiquetaBotonCancelar,
                      onChangedCallback: () {
                        Navigator.pop(
                          context,
                          CupertinoPageRoute<void>(
                              builder: (BuildContext context) =>
                                  DetalleMaquina(maquina: widget.maquina)),
                        );
                      },
                    )),
                    const SizedBox(width: 4),
                    Flexible(
                        child: ButtonDrawer(
                      titulo: etiquetaBotonSiguiente,
                      onChangedCallback: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute<void>(
                              builder: (BuildContext context) =>
                                  LecturaPanel(maquina: widget.maquina)),
                        );
                      },
                    ))
                  ])
                ],
              )),
        ));
  }
}
