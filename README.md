

## Asynchronous Signal Synchronization

<img width="1490" height="348" alt="image" src="https://github.com/user-attachments/assets/68edac06-1702-41cd-81b3-58ba9f79a162" />

An asynchronous signal can change at any time, so we use two FFs to make the signal stable.  
The first flip-flop samples it and may become unstable (metastable).  
The second flip-flop samples the first one on the next clock edge, after it has had time to settle to a clean 0 or 1.  
This makes the output signal stable and safe to use inside our clocked system.

---

## Time-to-Digital Converter (TDC)

<img width="1486" height="283" alt="image" src="https://github.com/user-attachments/assets/44309767-ecd2-4326-9733-4b91bca3d521" />

To measure the distance/error of two signals, we use a Time-to-Digital Converter (TDC).  
The TDC works by starting a timer at the posedge of the reference signal and stop the timer at the posedge of the feedback signal.  
A positive counter value represents that the reference signal is ahead of the feedback or compared signal.  
A negative counter value represents that the feedback or compared signal is ahead of the reference signal.

---

## Proportional Integral Loop Filter

<img width="706" height="110" alt="image" src="https://github.com/user-attachments/assets/074ec180-151c-4c98-888f-cae216cee7d7" />

We use a proportional integral loop filter to turn the digital value into the accumulation value we need to change the speed of our signals.  
Kp reacts immediately to the current TDC error and Ki slowly accumulates error.  
Each clock cycle, it updates an accumulator using the previous value plus the proportional term and a small integral increment.

---

## Numerically Controlled Oscillator (NCO)

<img width="428" height="213" alt="image" src="https://github.com/user-attachments/assets/b9010bb5-8b67-46f9-a2de-bfaece344a8c" />

The NCO adds the accumulator value to the phase every clock, so the phase keeps increasing at a rate set by the accumulator value.  
The MSB of the phase is used as the output and a square wave whose frequency depends on how fast the phase wraps around.  
0 MSB means the phase is in the first half of the cycle.  
1 MSB means the phase is in the second half of the cycle.

---
