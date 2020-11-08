class TableroMemoria{
  color matriz[][] = new color[21][10];
  
  TableroMemoria(){                            //Inicializamos el tablero con una fila de 1 abajo para detectar las colisiones con el "piso"
    for (int i=0; i<10; i++){
      matriz[20][i]= 1;
    }  
  }
  
  
  void EliminarFila(){
    for (int i=19; i >=0; i--) {
      FilaCompleta= true;
      for (int j=0; j < 10; j++) {
        if (matriz[i][j]==0){
          FilaCompleta= false;
        }
      }
      if (FilaCompleta == true){
        FilasCompletadas++;
        for (int k=i; k >0; k--) {
          matriz[k]=matriz[k-1];
        }
      }
    }
  }
  
  void DibujarTablero(){                                          //Recorremos cada celda y dibujamos un rectangulo con el color que esta guarda
    for (int i=0; i < 20; i++) {
      for (int j=0; j < 10; j++) {
        fill(matriz[i][j]);
        square(j*30 +30, i*30 + 30, 30);
      }
    }
  }
  
}
