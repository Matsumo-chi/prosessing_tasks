PFont font; //フォント
PImage img; //前回の画像として保存するため
int[] shape = new int[0]; //
int shape_X1, shape_X2, shape_Y1, shape_Y2, cirX, cirY, X1, X2, Y1, Y2; //
boolean square, circle, move, clear, select; //
int [] rec ={20, 90, 160, 230, 300}; //
//String [] mode = {"square", "circle", "move", "clear"};
String [] shap = {"四角", "丸", "選択", "削除", "終了"}; //

void setup() {
  size(500, 500);//
  img = loadImage("lastpic.png");
  PFont font = createFont("MS Gothic", 50);
  textFont(font);//フォントを宣言
  textSize(20);//文字の大きさを指定
  textAlign(LEFT);//文字表示を左にする関数
  Buttons();//ボタンを表示する
  image(img, 0, 0);//前回終了時に保存した画像を表示する
}

void draw() {//繰り返す関数
  if (clear) {//clearがtrueだった場合
    fill(200);//色指定
    rect(0, 0, 500, 500);//四角を描く（画面が白紙にリセットする）
    Buttons();//ボタンを作る
  }
}

void mousePressed() {//マウスのボタンが押されたら呼び出される関数
  if (square  || circle ) {//squareかcircleがtrueだったとき
    if (mouseY > 100) {//マウスのある位置が100よりも下だったとき
      shape = append(shape, mouseX);
      shape = append(shape, mouseY);
      println(shape.length % 4);
    }
  }

//ボタンの処理

  //  (1)四角
  if (rec[0] < mouseX && mouseX <rec[0]+30 && 20 < mouseY && mouseY < 50 ) {
    flag_off();
    square = true;
    //println("square："+square+"  circle："+circle);
    println(shap[0]);
    fill(#7CDDFF); // 青色に塗る
    rect(rec[0], 20, 50, 30);
  }

  //  (2)丸
  if (rec[1] < mouseX && mouseX < rec[1]+30 && 20 < mouseY && mouseY < 50 ) {
    flag_off();
    circle = true;
    Buttons();
    println(shap[1]);
    fill(#7CDDFF); // 青色に塗る
    rect(rec[1], 20, 50, 30);
  }
  //  (3)選択
  if (rec[2] < mouseX && mouseX < rec[2]+30 && 20 < mouseY && mouseY < 50 ) {
    flag_off();
    move = true;
    Buttons();
    println(shap[2]);
    println(move);
    fill(#7CDDFF); // 青色に塗る
    rect(rec[2], 20, 50, 30);
  }

  //  削除
  if (rec[3] < mouseX && mouseX <rec[3]+30 && 20 < mouseY && mouseY < 50 ) {
    flag_off();
    clear = true;
    println(shap[3]);
    fill(#7CDDFF); // 青色に塗る
    rect(rec[3], 20, 50, 30);
  }

  //  (4)保存終了
  if (rec[4] < mouseX && mouseX <rec[4]+30 && 20 < mouseY && mouseY < 50 ) {
    flag_off();
    Buttons();
    save("lastpic.png");
    println(shap[4]);
    exit();
  }


  println(shape);
  if (move == true) {
    if (shape_X1 < mouseX && mouseX < shape_X2 && shape_Y1 < mouseY && mouseY < shape_Y2) {
      println("選択中");
      select = true;
    }
  }
  fill(0);
  for (int i=0; i<5; i++) { //text
    text(shap[i], rec[i], 50);
  }
}

void mouseMoved() {
  if (move == true && select == true) {
    println("動いてる");
    rect(shape[shape_X1], shape[shape_Y1], shape[shape_X2]-shape[shape_X1], shape[shape_Y2]-shape[shape_Y1]);
  }
}

void mouseReleased() {
  fill(255);
  if(mouseY > 100){
    println("shape 動作中");
  shape_X1 = shape.length-4;
  shape_Y1 = shape.length-3;
  shape_X2 = shape.length-2;
  shape_Y2 = shape.length-1;
  }
  if (mouseY > 100 && 0 < shape.length && shape.length%4 == 0) {
    if(square){
      rect(shape[shape_X1], shape[shape_Y1], shape[shape_X2]-shape[shape_X1], shape[shape_Y2]-shape[shape_Y1]);
    }
    if(circle){
      cirX = (shape[shape_X1]+shape[shape_X2])/2;
      cirY = (shape[shape_Y1]+shape[shape_Y2])/2;
      ellipse(cirX, cirY, shape[shape_X2]-shape[shape_X1], shape[shape_X2]-shape[shape_X1]);
    }
  }
}

//    ボタン描画
void Buttons() {
  fill(255);
  for (int i=0; i<5; i++) { //botton
    rect(rec[i], 20, 50, 30);
  }
  fill(0);
  for (int i=0; i<5; i++) { //textaaf
    text(shap[i], rec[i], 50);
  }
}

void flag_off() {//すべてをfalseにするための関数
  square = false;
  circle = false;
  move = false;
  clear = false;
  select = false;
}
