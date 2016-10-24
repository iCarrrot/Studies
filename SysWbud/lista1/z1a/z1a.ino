const int minBut = 2;     // the number of the pushbutton pin
const int maxBut = 4;
int Max=1024;
int Min=0;
int fotoPin = 0; 
int led;
int led3 = 9;  
int led1 = 10; 
int led2 = 11; 
int brightness = 0;  
int fotoDane;   
float wsp=(Max-Min)/255.0;
void setup(void) {
  Serial.begin(9600);  
  pinMode(led3, OUTPUT);
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
  pinMode(maxBut, INPUT);
  pinMode(minBut, INPUT);
}
void loop(void) {
  analogWrite(led,0);//wyłącz poprzednią diodę
  led =9;
  fotoDane = analogRead(fotoPin);//czytaj jasność
  
  if(Max<fotoDane){//mapuj jasność otoczenia na jasność diody
    brightness=0 ;
  }
  else{
    if(Min>fotoDane){
      brightness=255;
    }
    else{
      
     brightness=map(fotoDane,Min,Max,255,0);
    }
  }
  if(digitalRead(maxBut)==HIGH){//jezeli guzik wciśnięty, to zapisz jasność otoczenia
    Max=fotoDane;

  }
  if(digitalRead(minBut)==HIGH) {
    Min=fotoDane; 

  }
  analogWrite(led, brightness);//zaświeć diodę
  delay(100);//poczekaj 0,1s
}


