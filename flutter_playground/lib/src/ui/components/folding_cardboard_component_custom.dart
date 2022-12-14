import 'package:flutter/material.dart';

class FoldingCardboardComponentCustom extends StatefulWidget {
  final Color colorMain;
  final Color backgroundColor;
  final Color cellColor;
  final Color cellText;
  final String title;
  final BingoTicketFoldingCardboardModel bingoTicketModel;
  final EdgeInsetsGeometry padding;
  final double borderRadiusCircularCardBoard;
  final double borderRadiusCircularCell;
  ///-- INFO --
  ///
  ///(Grupo 2 Semana 2)
  ///
  ///Colaboradores en este widget: Caliva Gaston, Fadel Nicolas, Fernandez Lourdes.
  ///
  ///Carton de bingo desplegable (animado), recibe un modelo de bingo con las siguientes propiedades 'int number, List <int> numberList,
  ///estas propiedades generan un numero de carton y una lista con x cantidad de numeros que rellenan las celdas del carton.
  ///
  ///Atributos propios del custom widget: Color background, Color colorMain, Color cellColor, Color cellText, String title,
  ///EdgeInsetsGeometry padding, double borderRadiusCircularCardBoard, double borderRadiusCircularCell.
  ///
  const FoldingCardboardComponentCustom({
    Key? key,
    this.title = "Número de cartón",
    required this.bingoTicketModel,
    this.colorMain = const Color.fromARGB(255, 33, 82, 243),
    this.backgroundColor = Colors.white,
    this.cellText = Colors.black54,
    this.cellColor = const Color.fromARGB(255, 239, 239, 239),
    this.padding = const EdgeInsets.all(8),
    this.borderRadiusCircularCardBoard = 12,
    this.borderRadiusCircularCell = 6,
  }) : super(key: key);

  @override
  State<FoldingCardboardComponentCustom> createState() =>
      _FoldingCardboardComponentCustomState();
}

class _FoldingCardboardComponentCustomState
    extends State<FoldingCardboardComponentCustom>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  double sizeTable = 0;

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width.toDouble();
    late final double sizeCell = size/9;//size / 9 >= 45 ? 45 : size / 9;
    late final double sizeNumber = size / 9 >= 63 ? 23.625 : size / 24;;//size / 9 >= 52 ? 19.5 : size / 24;
    late final double sizeText = size / 9 >= 52 ? 19.5 : size / 26;
    late final double sizeContainerMainNumber =
        size / 4.8 >= 90 ? 90 : size / 4.8;
    late final double sizeIcon = size / 10.4 >= 45 ? 45 : size / 10.4;
    late final double sizeWidget = sizeCell * 7 + widget.padding.horizontal.toDouble() * 2 + 5 * 14;
    const double marginCell = 3;
    List<TableRow> carton = List.generate(
        5,
        (indexCol) => TableRow(
            children: List.generate(
                7,
                (indexRow) =>
                    _cell(indexCol * 7 + indexRow, sizeCell, sizeNumber, marginCell))));
    return _expansionTable(
        carton, sizeCell, sizeText, sizeContainerMainNumber, sizeIcon,sizeWidget,marginCell);
  }

  void onTap() {
    setState(() {
      if (!_isOpen) {
        sizeTable = 
        (MediaQuery.of(context).size.width.toDouble() / 9 >= 52
                ? 52
                : (MediaQuery.of(context).size.width.toDouble() / 9) * 5) +
            55;
      } else {
        sizeTable = 0;
      }
      _isOpen = !_isOpen;
    });
  }

  _cell(index, sizeCell, sizeNumber, marginCell) {
    return Container(
      width: sizeCell,
      height: sizeCell,
      margin: EdgeInsets.all(
          marginCell), //index%7 == 0 ? const EdgeInsets.only(right: 5) : const EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          color: widget.cellColor, //Colors.grey.shade200
          borderRadius: BorderRadius.circular(widget.borderRadiusCircularCell),
          /*boxShadow: [
            BoxShadow(
              color: widget.cellColor.withOpacity(0.9),
              blurRadius: 1,
              offset: const Offset(3.5, 3.5),
            ),
          ]
          */
          ),
      alignment: Alignment.center,
      child: Text(
        addNumbers(index),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: sizeNumber,
          color: widget.cellText, //Colors.black54
        ),
      ),
    );
  }

  String addNumbers(index) {
    if (index < widget.bingoTicketModel.numberList.length) {
      return widget.bingoTicketModel.numberList[index].toString();
    } else {
      return "-";
    }
  }

  _expansionTable(
      carton, sizeCell, sizeText, sizeContainerMainNumber, sizeIcon,sizeWidget,marginCell) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(widget.borderRadiusCircularCardBoard),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ]),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(widget.borderRadiusCircularCardBoard),
          child: Container(
            width: sizeWidget,//double.infinity,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
            ),
            child: Padding(
              padding: widget
                  .padding, //const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 5),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " ${widget.title}",
                        style: TextStyle(
                          fontSize: sizeText,
                          fontWeight: FontWeight.w500,
                          color: widget.colorMain, //topBarColor
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Container(
                              height: sizeContainerMainNumber / 3.25,
                              width: sizeContainerMainNumber,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.5,
                                  color: widget.colorMain, //topBarColor
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.bingoTicketModel.number.toString(),
                                style: TextStyle(
                                  color: widget.colorMain, //topBarColor
                                  fontWeight: FontWeight.w600,
                                  fontSize: sizeText / 1.15,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                            AnimatedRotation(
                              turns: _isOpen ? 0 : -0.5, 
                              duration: const Duration(milliseconds:200),
                              child: Icon(
                                Icons.arrow_drop_down,
                                size: sizeIcon,
                                color: widget.colorMain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                    height: 
                    
                    _isOpen
                        ? sizeCell * 5 + marginCell*10 + 5
                        : 0, //sizeCell*5+55, //(MediaQuery.of(context).size.width.toDouble() / 9 >= 52 ? 52 : (MediaQuery.of(context).size.width.toDouble() / 9)*5) + 55,//_isOpen ? sizeTable : (MediaQuery.of(context).size.width.toDouble() / 9 >= 52 ? 52 : (MediaQuery.of(context).size.width.toDouble() / 9)*5) + 55,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: widget.padding.vertical / 3,
                          right:
                              5), //const EdgeInsets.only(top: 10,left: 5,right: 10),
                      child: Table(
                        children: carton,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BingoTicketFoldingCardboardModel{
  int number;
  List<int> numberList;
  BingoTicketFoldingCardboardModel({required this.number, required this.numberList});
}