// no borrar
surface.setVisible(false);
size(400,400);
// solucion debajo
int n = parseInt(args[0]);
background(0);
ellipseMode(CORNER);
for (int y = 0; y < 400; y += width/n) {
  for (int x = 0; x < 400; x += width/n) {
    ellipse(x,y,width/n,width/n);
  }
}
// no borrar esto y dejar al final
save("circulos.png");
exit();
