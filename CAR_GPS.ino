#include <SoftwareSerial.h>
#include <Servo.h> 
#include <math.h>
#include <HMC5883L.h>
//===================================定義馬達腳位參數===============================
int pinLB=11;     // 定義6腳位 左後
int pinLF=10;     // 定義9腳位 左前

int pinRB=8;    // 定義10腳位 右後
int pinRF=9;    // 定義11腳位 右前


int Fspeedd = 0;      // 前速
int Rspeedd = 0;      // 右速
int Lspeedd = 0;      // 左速
int directionn = 0;   // 前=8 後=2 左=4 右=6 
Servo myservo;        // 設 myservo
int delay_time = 250; // 伺服馬達轉向後的穩定時間

int Fgo = 8;         // 前進
int Rgo = 6;         // 右轉
int Lgo = 4;         // 左轉
int Bgo = 2;         // 倒車

//=======================定義羅盤腳位參數====================================================

double degree=0;//現在角度
HMC5883L compass;
//========================定義GPS腳位參數================================================
SoftwareSerial GPS(6, 7);
float latitude,longitude;//經緯度數值
//========================定義超音波參數================================================
const int trig = 5;
const int echo = 6;
const int inter_time = 1000;
float obstacle=0;
//=======================定義紅外線參數===============================================
const int pir =4 ;
boolean HumanDetect();

//==================================結束===============================================


void setup()
 {
      // 定義馬達輸出腳位 
  pinMode(pinLB,OUTPUT); // 腳位 8 (PWM)
  pinMode(pinLF,OUTPUT); // 腳位 9 (PWM)
  pinMode(pinRB,OUTPUT); // 腳位 10 (PWM) 
  pinMode(pinRF,OUTPUT); // 腳位 11 (PWM)

  pinMode(13,OUTPUT); 
  pinMode(12,OUTPUT); 

  
  //設置HMC5883
  compass.setRange(HMC5883L_RANGE_1_3GA);
  compass.setMeasurementMode(HMC5883L_CONTINOUS);
  compass.setDataRate(HMC5883L_DATARATE_15HZ);
  compass.setSamples(HMC5883L_SAMPLES_1);
  checkSettings();
  
//超音波設置
  pinMode (trig, OUTPUT);
  pinMode (echo, INPUT);

//紅外線設置
  pinMode(pir,INPUT); 
  
  Serial.begin(9600); 
  

 }
 
boolean HumanDetect(){
  return  digitalRead(pir);
  }
//=================================HMC5883L設定=================================
void checkSettings()
{
  Serial.print("Selected range: ");
  
  switch (compass.getRange())
  {
    case HMC5883L_RANGE_0_88GA: Serial.println("0.88 Ga"); break;
    case HMC5883L_RANGE_1_3GA:  Serial.println("1.3 Ga"); break;
    case HMC5883L_RANGE_1_9GA:  Serial.println("1.9 Ga"); break;
    case HMC5883L_RANGE_2_5GA:  Serial.println("2.5 Ga"); break;
    case HMC5883L_RANGE_4GA:    Serial.println("4 Ga"); break;
    case HMC5883L_RANGE_4_7GA:  Serial.println("4.7 Ga"); break;
    case HMC5883L_RANGE_5_6GA:  Serial.println("5.6 Ga"); break;
    case HMC5883L_RANGE_8_1GA:  Serial.println("8.1 Ga"); break;
    default: Serial.println("Bad range!");
  }
  
  Serial.print("Selected Measurement Mode: ");
  switch (compass.getMeasurementMode())
  {  
    case HMC5883L_IDLE: Serial.println("Idle mode"); break;
    case HMC5883L_SINGLE:  Serial.println("Single-Measurement"); break;
    case HMC5883L_CONTINOUS:  Serial.println("Continuous-Measurement"); break;
    default: Serial.println("Bad mode!");
  }

  Serial.print("Selected Data Rate: ");
  switch (compass.getDataRate())
  {  
    case HMC5883L_DATARATE_0_75_HZ: Serial.println("0.75 Hz"); break;
    case HMC5883L_DATARATE_1_5HZ:  Serial.println("1.5 Hz"); break;
    case HMC5883L_DATARATE_3HZ:  Serial.println("3 Hz"); break;
    case HMC5883L_DATARATE_7_5HZ: Serial.println("7.5 Hz"); break;
    case HMC5883L_DATARATE_15HZ:  Serial.println("15 Hz"); break;
    case HMC5883L_DATARATE_30HZ: Serial.println("30 Hz"); break;
    case HMC5883L_DATARATE_75HZ:  Serial.println("75 Hz"); break;
    default: Serial.println("Bad data rate!");
  }
  
  Serial.print("Selected number of samples: ");
  switch (compass.getSamples())
  {  
    case HMC5883L_SAMPLES_1: Serial.println("1"); break;
    case HMC5883L_SAMPLES_2: Serial.println("2"); break;
    case HMC5883L_SAMPLES_4: Serial.println("4"); break;
    case HMC5883L_SAMPLES_8: Serial.println("8"); break;
    default: Serial.println("Bad number of samples!");
  }

}
  
  
//===============================量出前方距離===================================
void ObstacleMeasuring(){
  float duration, distance;
  digitalWrite(trig, HIGH);
  delayMicroseconds(1000);
  digitalWrite(trig, LOW);
  duration = pulseIn (echo, HIGH);
  distance = (duration/2)/29;
  obstacle=distance;
  }
  
//=================================讀取方位=====================================
  void DegreeSet()//設定角度
  {
  Vector norm = compass.readNormalize();
  degree =  atan2(norm.YAxis,norm.XAxis)*(180/PI)+180;
  }

    

//===================================馬達動作=====================================
void advance(int a)     // 前進
    {
     digitalWrite(pinRB,LOW);  // 使馬達（右後）動作
     digitalWrite(pinRF,HIGH);
     digitalWrite(pinLB,LOW);  // 使馬達（左後）動作
     digitalWrite(pinLF,HIGH);
     analogWrite(pinRB, 0);
     analogWrite(pinRF, 130);
     analogWrite(pinLB, 0);
     analogWrite(pinLF, 130);
     
     delay(a * 100);     
    }

void right(int b)        //右轉(單輪)
    {
     digitalWrite(pinRB,LOW);   //使馬達（右後）動作
     digitalWrite(pinRF,HIGH);
     digitalWrite(pinLB,HIGH);
     digitalWrite(pinLF,HIGH);
     delay(b * 100);
    }
void left(int c)         //左轉(單輪)
    {
     digitalWrite(pinRB,HIGH);
     digitalWrite(pinRF,HIGH);
     digitalWrite(pinLB,LOW);   //使馬達（左後）動作
     digitalWrite(pinLF,HIGH);
     delay(c * 100);
    }
void turnR(int d)        //右轉(雙輪)
    {
     digitalWrite(pinRB,LOW);  //使馬達（右後）動作
     digitalWrite(pinRF,HIGH);
     digitalWrite(pinLB,HIGH);
     digitalWrite(pinLF,LOW);  //使馬達（左前）動作
     delay(d * 100);
    }
void turnL(int e)        //左轉(雙輪)
    {
     digitalWrite(pinRB,HIGH);
     digitalWrite(pinRF,LOW);   //使馬達（右前）動作
     digitalWrite(pinLB,LOW);   //使馬達（左後）動作
     digitalWrite(pinLF,HIGH);
     delay(e * 100);
    }    
void stopp(int f)         //停止
    {
     digitalWrite(pinRB,HIGH);
     digitalWrite(pinRF,HIGH);
     digitalWrite(pinLB,HIGH);
     digitalWrite(pinLF,HIGH);
     delay(f * 100);
    }
void back(int g)          //後退
    {

     digitalWrite(pinRB,HIGH);  //使馬達（右後）動作
     digitalWrite(pinRF,LOW);
     digitalWrite(pinLB,HIGH);  //使馬達（左後）動作
     digitalWrite(pinLF,LOW);
     delay(g * 100);     
    }
void Avoid(){
 back(2);
 turnR(5);
 advance(10);
 turnL(5);
 stopp(1);
  }
 
      
   void goDegree(int dire)//dire 目標方向   P/Noff 正負誤差
      {
        if(HumanDetect()){ //偵測人 Range:40cm
          advance(3);
          stopp(1);
        }
        else{
            if(dire<10||dire>350)
            dire=0;
            int Poff=dire+10;
            if(Poff>=360)
            Poff-=360;
            int Noff=dire-10;
           if(Noff<0)
           Noff+=360;
           //Serial.println(degree);
            //Serial.println(Poff);
            //Serial.println(Noff);
            if(dire==0){
              if(degree<10||degree>350)
              {
              advance(10); 
              stopp(1);
               } 
              }
              else if((degree<=Poff&&degree>=Noff)){ 
              advance(10); 
              stopp(1); 
              }
              else if(     (dire<180&&(degree>dire&&degree<dire+180)) ||(dire>180&& ( (degree>0&&degree<dire-180)||(degree<360&&degree>dire) ) ) ){
                //back(1);      
                turnL(2);
                stopp(8);      
                }
              else{
                //back(1);      
                turnR(3);
                stopp(8);                  
              }
        }

        if(obstacle<15)
         Avoid();
        }


  void goToDestination(float DesX,float DesY ){
  float nowX=latitude;
  float nowY=longitude;
  float dis=0,offY=0,offX=0;
  int derg = -1;
  dis=sqrt(pow(DesX-nowX,2)+pow(DesY-nowY,2));
  offY=abs(DesY-nowY);
  offX=abs(DesX-nowX);
  if(DesX>=nowX&&DesY>=nowY){     //往第一象限
   derg=asin(offY/dis); 
   }
  else if(DesX>=nowX &&DesY<nowY) {  //往第四象限
   
   derg=180-asin(offY/dis);  
    }
   else if(DesX<nowX&&DesY<nowY){//往第三象限
   
   derg=180+asin(offY/dis);
   }
   else if(DesX<nowX&&DesY>=nowY){ //往第二象限
   
   derg=360-asin(offY/dis); 
    }
    
    if(derg!=-1)
    goDegree(derg);
    else
    stopp(10);
  
  }

void loop()
 {
    ObstacleMeasuring(); // set  obstacle (cm)
    DegreeSet();
    //goDegree(90);
    //turnL(2);
    //stopp(1);
    advance(1);
    //Serial.println(HumanDetect());
 
 }


