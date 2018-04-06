

#define code1 0xFF807F //

#define code2 0xFFA05F //

#define code3 0xFF906F //
/*
Rsend irsend;
Create the transmit object. A fixed pin number is always used, depending on which timer the library is utilizing.

irsend.sendNEC(IRcode, numBits);
Send a code in NEC format.

irsend.sendSony(IRcode, numBits);
Send a code in Sony format.

irsend.sendRC5(IRcode, numBits);
Send a code in RC5 format.

irsend.sendRC6(IRcode, numBits);
Send a code in RC6

irsend.sendRaw(rawbuf, rawlen, frequency);
*/
#include <IRremote.h>

int diod = 12; //
IRsend irsend; 

void setup() {
Serial.begin(9600); //
}

void loop() {
irsend.sendNEC(0x68B92, 20);
delay(100);
}
