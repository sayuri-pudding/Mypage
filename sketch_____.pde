//ジュース
//オレンジジュースを飲んでいる時のストローを細かく描写
//1年４組５０番　松田さゆり
//2019年７月１７日
import ddf.minim.*;
Minim minim;
AudioSnippet crash;


int stro=0;
int jc=200;
PFont font;
PFont font2;
int p=0;
int n;
void setup()
{
  size(500, 900);//ウインドウサイズを５００×９００に設定
  font=loadFont("MS-Gothic-24.vlw");//文字の読み込み
  font2=loadFont("Arial-Black-48.vlw");
  minim=new Minim(this);
  crash=minim. loadSnippet("ごくごく飲む.mp3");
}

void draw()
{
  background(255);

  //ストロー外枠
  noFill();
  strokeWeight(3);
  stroke(0);
  rect(310, 100, 25, 200);
  //ジュース
  fill(255, 200, 0);
  if (jc==0)
  {
    if (n<200)//ジュースがなくなったときに吸い込まれる
    {
      rect(310, 100, 25, 200-n);
      n=n+20;
    }
  }
  if (p==1)//マウスが押されているとき
  { 
    rect(310, 300-stro, 25, 200);//ジュースがストローを登っていく
    if (stro<=200)//ジュースがストローより上にいかないようにする
    {
      stro++;
    }
    if (stro>=200)//ジュースが飲み口に到達したときに、残量が減るようにする
    {
      jc--;
      if (jc<=0)
      {
        jc=0;//ジュースがまいなすにいかないようにする
        p=3;//飲み切るアニメーションにうつる
      }
    }
  }

  if (p==3)
  {
    fill(255);
    rect(310, 300, 25, 200);
  }
  if (p==2)//ボタンを離したときに落ちていくようにする
  {
    if (jc>0)
    {
      rect(310, 300-stro, 25, 200);
      stro=stro-2;//早めに落ちていくようにする
      if (stro<=0)//残量がゼロの時に何も起きないようにする
      {
        p=0;
      }
    }
  }


  //箱
  fill(240, 220, 0);
  stroke(0);
  rect(125, 300, 250, 500);

  //文字
  fill(0, 0, 80);
  rect(160, 400, 170, 20);


  textFont(font);


  textSize(40);
  text("Orange", (125+375)/2-90, 460);
  text("Juice", (125+375)/2-90, 510);

  textSize(28);
  text("果汁100％ 濃縮還元", 125, 790);
  text("残量"+jc+"ml", 200, 750);

  fill(255, 0, 0);
  textSize(70);
  textFont(font2, 70);
  text("Dole", 155, 400);

  noFill();
  strokeWeight(7);
  stroke(255, 255, 0);
  ellipse(230, 380, 20, 20);
}

void keyPressed()
{
  if (310>mouseX ||mouseX<335 && mouseY>100 || mouseY<300)//マウスがストローの上にあるときだけ反応する
  {
    if (jc>0)//残量があったら、ｐが１
    {
      p=1;
    }
  }
}
void keyReleased()//ボタンを離したときにｐが２
{
  p=2;
  crash.rewind();//キーを離したときにごくごく飲む音を出す
  crash.play();
}
void stop()
{
  crash.close();
  minim.stop();
  super.stop();
}
