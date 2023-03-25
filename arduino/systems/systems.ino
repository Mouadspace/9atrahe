#define trig 11
#define echo 12

int data = 0;
//int led = 13; // led attach to pin 13

const int buzzer = 9; // attach buzzer to pin 9
const int waterSensor = A0; // attach sensor to pin a0
int sensorValue;
bool isleak = 0;
char buffer[40];


int distance = 0, t = 0;
const int waterPump = 13; 
int tempConsomation = 0;
double tempConsomation1 = 0;
double tempConsomation2 = 0;


void setup() {
  //  pinMode(led, OUTPUT);
  pinMode(buzzer, OUTPUT);
  pinMode(waterSensor, INPUT);
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(waterPump, OUTPUT);
  Serial.begin(9600);

}

void loop() {
  digitalWrite(trig, LOW);
  delayMicroseconds(5);
  digitalWrite(trig, HIGH);
  delayMicroseconds(10);
  digitalWrite(trig, LOW);
  t = pulseIn(echo, HIGH);
  distance = t / 57;
  delay(50);

  if (distance < 15 && distance > 5 && isleak == 0 ) {
    tempConsomation1 = millis();

    digitalWrite(waterPump, HIGH);
    delay(1000);
    tempConsomation2 = millis();

    tempConsomation += ( tempConsomation2 - tempConsomation1 ) ;

  }
  else {
    digitalWrite(waterPump, LOW);
  }


  sensorValue = analogRead(waterSensor);
  if (sensorValue > 50) {
    tone(buzzer, 800, 500);
    delay(200);
    tone(buzzer, 600, 500);
    isleak = 1;
    sprintf(buffer, "1.%d", tempConsomation / 1000);
    Serial.println(buffer);
    delay(500);

  }
  else {
    sprintf(buffer, "0.%d", tempConsomation / 1000);
    Serial.println(buffer);
    isleak = 0;
    delay(500);
  }




  if (Serial.available() > 0) {
    data = Serial.read();
    if (data == '1' && isleak == 0 ) {
      digitalWrite(waterPump, HIGH);
      delay(2000);
      digitalWrite(waterPump, LOW);

      tempConsomation = tempConsomation + 1000;

    } else if (data == '0' && !isleak) {
      digitalWrite(waterPump, HIGH);
      delay(4000);
      digitalWrite(waterPump, LOW);
      tempConsomation = tempConsomation + 2000;

    }
    delay(10);
  }
}
