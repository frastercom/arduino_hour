#include <Wire.h>
#include <LiquidCrystal_I2C.h>

// macros from DateTime.h 
/* Useful Constants */
#define SECS_PER_MIN  (60UL)
#define SECS_PER_HOUR (3600UL)
#define SECS_PER_DAY  (SECS_PER_HOUR * 24L)
 
/* Useful Macros for getting elapsed time */
#define numberOfSeconds(_time_) (_time_ % SECS_PER_MIN)  
#define numberOfMinutes(_time_) ((_time_ / SECS_PER_MIN) % SECS_PER_MIN) 
#define numberOfHours(_time_) (( _time_% SECS_PER_DAY) / SECS_PER_HOUR)
#define elapsedDays(_time_) ( _time_ / SECS_PER_DAY)  

int levelMenu = 0;
int courseMenu = 0;
const int buttonPin = 7;
const int buttonPin1 = 6;
unsigned long startTime;
// Указываем адрес LCD и размер
LiquidCrystal_I2C lcd(0x27, 16, 2); // Замените 0x27 на адрес вашего LCD, если он другой

void setup() {
  pinMode(buttonPin, INPUT);
  pinMode(buttonPin1, INPUT);
  // Инициализация LCD с указанием размера
  lcd.begin(16, 2);
  lcd.backlight(); // Включаем подсветку
  // Выводим "Привет" на второй строке
  lcd.setCursor(0, 0); // Устанавливаем курсор в начало
  lcd.clear();
  startTime = 0;
}

void loop() {
  // Здесь можно добавить код, который будет выполняться в цикле
  printTime(startTime );// начальное время 10 May 1971 г., 15:56:40
  if (digitalRead(buttonPin) == HIGH) {
    startTime = startTime + 3600000 ;
    delay(500);
  }
  if (digitalRead(buttonPin1) == HIGH) {
    startTime = startTime + 60000 ;
    delay(500);
  }
  

}

void printTime(unsigned long time) {
  uint32_t val = (millis() + time) / 1000ul;// время в секундах
  int timeHours = numberOfHours(val);// время в часах
 int timeMins = numberOfMinutes(val);// время в в минутах
  lcdPrintTime(String(timeHours), String(timeMins));
}

void lcdPrintTime(String hour, String minutes) {
  lcdPrint(transfor(hour)+":"+transfor(minutes));
}

String transfor(String time) {
  if (time.length() > 1) {
    return time;
  }
  return "0"+time;
}

void lcdPrint(String text) {
  // lcd.clear();
  lcd.setCursor(0, 0); // Устанавливаем курсор в начало
  lcd.print(text);
}



