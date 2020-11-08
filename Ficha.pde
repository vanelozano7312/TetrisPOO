class Ficha {
  // Cada tetromino con sus rotaciones representado por un numero con una matriz binaria de 4x4
  int[] c = {61440, 34952, 61440, 34952};
  int[] n = {59392, 3140, 11776, 35008};
  int[] v = {27648, 35904, 27648, 35904};
  int[] r = {50688, 19584, 50688, 19584};
  int[] a = {57856, 17600, 36352, 51328};
  int[] o = {52224, 52224, 52224, 52224};
  int[] m = {58368, 19520, 19968, 35968};
  color Color;
  int[] Rotaciones;
  int[] Posicion = {0, 0, 0, 0, 0, 0, 0, 0};
  int MaximaPosicion;
  
  Ficha(int valor){   
    MaximaPosicion=8;                       //Inicializamos la ficha con su color y su lista de numeros correspondientes
    if (valor==0){
      Color = #abcd6f;
      Rotaciones=c;
      MaximaPosicion=7;
    } else if (valor==1){
      Color = #ed6a3c;
      Rotaciones=n;
    } else if (valor==2){
      Color = #40b181;
      Rotaciones=v;
    } else if (valor==3){
      Color = #e61b48;
      Rotaciones=r;
    } else if (valor==4){
      Color = #fbbf53;
      Rotaciones=o;
    } else if (valor==5){
      Color = #24366d;
      Rotaciones=a;
    } else if (valor==6){
      Color = #6c1f61;
      Rotaciones=m;
    }
  }
  
  void Dibujar() {
    int q=0;
    MovDerecha = true;
    MovIzquierda = true;
    RotacionDerecha = false;
    push();
    fill(Color);
    for (int i = 0; i <= 16; i++) {
      if ((Rotaciones[rotacion] & (1 << 15 - i)) != 0) {
        Posicion[q]=(((i / 4) | 0) + 1 +y );                     //agrego la posición en la matriz tablero de cada cuadrado del Tetromino
        Posicion[q+1]=((i % 4)+x+4);
        if (((i % 4)+x+4)<MaximaPosicion){                       //Verifico si la ficha no está a la derecha del todo para que pueda rotar
          RotacionDerecha = true;
        }
        if (((i % 4)+x+4)==9){                                   //Si algun cuadrado del tetromino está en el limite a der o izq no lo dejo moverse más
          MovDerecha = false;
        } else if (((i % 4)+x+4) == 0){
          MovIzquierda = false;
        }
        q+=2;
        rect(((i % 4)+x+5)*30, (((i / 4) | 0) + y+1)*30, 30, 30);
      }
    }
      pop();
  }
  void DibujarSiguiente(){                                       //Dibujo el tetromino que sigue a la derecha del tablero
    for(int p=0; p<8; p++){
      push();
      fill(Color);
      for (int i = 0; i <= 16; i++) {
        if ((Rotaciones[0] & (1 << 15 - i)) != 0) {
          rect(((i % 4)+13)*30, (((i / 4) | 0) + 2)*30, 30, 30);
        }
      }
      pop();
    }
  }
  
  void Colisiones(TableroMemoria tab){
    
    //Verifica si en las posiciones siguientes habrán colisiones
    if ((tab.matriz)[Posicion[0]+1][Posicion[1]]!=0 | (tab.matriz)[Posicion[2]+1][Posicion[3]]!=0  | (tab.matriz)[Posicion[4]+1][Posicion[5]]!=0  | (tab.matriz)[Posicion[6]+1][Posicion[7]]!=0 ){
      BajarCompleto=true;
      x=0;
      y=0;
      rotacion=0;
      Tetromino= SiguienteTetromino;
      SiguienteTetromino = (int)random(7);
      for(int i=0; i<8; i+=2){                                              // Guarda los colores de la ficha en la matriz tablero
        tab.matriz[Posicion[i]][Posicion[i+1]] = Color;
      }
      tab.EliminarFila();
      for(int s=0; s<8; s+=2){                                              //Verificamos si el espacio para que salga el nuevo tetromino está libre, si no es así es game over
        if (Posicion[s]==1){
          juego = false;
          image(GameOver, 30, 30, 300, 600);
          textSize(40);
          fill(255);
          text(Puntaje, 130, 270);
        }
      }
    }
    
    //Verificamos si hay colisiones a la derecha
    if (MovDerecha== true && (tab.matriz)[Posicion[0]][Posicion[1]+1]!=0 | (tab.matriz)[Posicion[2]][Posicion[3]+1]!=0  | (tab.matriz)[Posicion[4]][Posicion[5]+1]!=0  | (tab.matriz)[Posicion[6]][Posicion[7]+1]!=0 ){
      MovDerecha= false;
    }
    //Verificamos si hay colisiones a la izquierda
    if (MovIzquierda== true && (tab.matriz)[Posicion[0]][Posicion[1]-1]!=0 | (tab.matriz)[Posicion[2]][Posicion[3]-1]!=0  | (tab.matriz)[Posicion[4]][Posicion[5]-1]!=0  | (tab.matriz)[Posicion[6]][Posicion[7]-1]!=0 ){
      MovIzquierda= false;
    }
  }
  
  //Bajar la ficha a la máxima posicion
  void BajarFicha(){
    BajarCompleto = false;
    while (BajarCompleto == false){
      y++;
      FichaActual.Dibujar();
      FichaActual.Colisiones(Tablero);
    }
  }
}
