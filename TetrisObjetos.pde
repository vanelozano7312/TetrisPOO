int Puntaje, Nivel, FilasCompletadas, FichasBajadas, rotacion, x, y, Tetromino, SiguienteTetromino, TiempoAnterior;
Boolean juego = null;
Boolean MovDerecha, MovIzquierda, RotacionDerecha, FilaCompleta, BajarCompleto, instruccion;
PImage PagPrincipal, Instrucciones, TableroJuego, GameOver;
Ficha FichaActual, FichaSiguiente;
TableroMemoria Tablero;

void setup() {
  noStroke();
  size(540, 660);
  instruccion=false;
  Tetromino = (int)random(7);                      //Escojo las 2 primeras fichas y dibujo una como actual y la otra como siguiente
  SiguienteTetromino = (int)random(7);
  FichaActual = new Ficha(Tetromino);
  FichaSiguiente = new Ficha(SiguienteTetromino);
  Tablero = new TableroMemoria();
  PagPrincipal = loadImage("PagPrincipal.jpg");
  Instrucciones = loadImage("Instrucciones.jpg");
  TableroJuego = loadImage("TableroJuego.jpg");
  GameOver = loadImage("GameOver.png");
  image(PagPrincipal, 0, 0, width, height);
}

void draw(){
  FichaActual = new Ficha(Tetromino);
  FichaSiguiente = new Ficha(SiguienteTetromino);
  int Tiempo = millis();
  Puntaje = FilasCompletadas*100 + FichasBajadas*20;
  Nivel = floor(FilasCompletadas/10) + 1;
  
  
  if (juego==null && mouseX <=424  && mouseX>= 116 && mouseY<= 386 && mouseY>= 326 && mousePressed == true){               //Iniciamos el juego con la pantalla de inicio y vemos si el jugador
    juego=true;                                                                                                            //presiona jugar o instrucciones para poder iniciar juego (juego=true)
  }else if(juego==null && mouseX <= 424 && mouseX>=116  && mouseY<=478  && mouseY>= 421 && mousePressed == true){
    image(Instrucciones, 0, 0, width, height);
    instruccion=true;
  }
  if (instruccion==true && mouseX <=311  && mouseX>=175  && mouseY<=634 && mouseY>=574 && mousePressed == true){
    juego=true;  
  }
  
  
  if (juego != null && juego == true){
    image(TableroJuego, 0, 0, width, height);
    Tablero.DibujarTablero();
    FichaActual.Dibujar();
    FichaActual.Colisiones(Tablero);
    FichaSiguiente.DibujarSiguiente();  
    if (Tiempo>=1000 & (floor(Tiempo/(1000-(Nivel*50))) > TiempoAnterior)){           //Verifico si ya ha pasado 1 segundo, si es asi bajo la ficha
      TiempoAnterior=floor(Tiempo/(1000-(Nivel*50)));                                 //La velocidad varria en cada nivel
      y++;
    }
    push();
    textSize(30);
    fill(255);
    text(Puntaje, 365, 250);
    text(Nivel, 364, 400);
    text(FilasCompletadas, 365, 550);
    pop();
  }
  
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && RotacionDerecha== true) {                      // Roto el tetromino
      rotacion++;
      rotacion = rotacion < 0 ? 3 : rotacion % 4;
    } else if (keyCode == DOWN && juego==true) {                       //Bajo la ficha lo máximo posible
      FichaActual.BajarFicha();
      FichasBajadas++;
    } else if (keyCode == RIGHT && MovDerecha== true) {
      x++;
    } else if (keyCode == LEFT && MovIzquierda== true) {
      x--;
    }
  }else if (key == ENTER && juego==false && juego!=null){
    juego=true;                                                 //Si el juego habia acabado y presionan enter empieza de nuevo
    Puntaje=0;
    Nivel=0;
    FilasCompletadas=0;
    FichasBajadas=0;
    rotacion=0;
    x=0;
    y=0;
    Tetromino=(int)random(7);
    SiguienteTetromino=(int)random(7);
    for (int i=0;i<20; i++){
      for(int j=0;j<10; j++){
        (Tablero.matriz)[i][j]=0;      
      }
    }
  }
}
