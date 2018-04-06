#include <IRremote.h>

int RECV_PIN = 11;

IRrecv irrecv(RECV_PIN);

decode_results results;
int address_rev = 0x8a75;

void setup()
{

Serial.begin(9600);

irrecv.enableIRIn(); // Start the receiver

}

void loop()
{

  if (irrecv.decode(&results)) 
  {
    int i = 0;
    for(i=0; i<16; i++)
      if(bitRead(results.value, i)==bitRead(address_rev, i)) 
      {
        Serial.println(results.value, BIN);
        char addr = results.value >> 24;// << 24;
        char revAddr = (( (results.value)  << 8 ) >> 24);
        // check
        bool areTheSame = (addr == ~revAddr);
        Serial.println(addr, BIN);
        Serial.println(revAddr, BIN);
        Serial.println(areTheSame);
        if(areTheSame)
        {
          char cmd = results.value << 16 >> 24;
          char revCmd = results.value << 24 >> 24;
          Serial.println(cmd, BIN);
          Serial.println(revCmd, BIN);
          Serial.println(cmd == ~revCmd);
          Serial.println(" --------\n");
        }
      }
         
    irrecv.resume(); // Receive the next value }
  
  }
}
