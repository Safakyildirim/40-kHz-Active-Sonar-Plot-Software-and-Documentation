
int trigPin = 13; 
int echoPin = 12;  
 
long zaman;
long mesafe;
 
void setup(){
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin,INPUT); 
  Serial.begin(9600); 
}
void loop()
{
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(5);
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);  
  zaman = pulseIn(echoPin, HIGH);
  mesafe= (zaman / 29.1)/2;    
  Serial.print("Uzaklik ");  
  Serial.print(mesafe);
  Serial.println(" cm");  
  delay(500); 
}
