//+------------------------------------------------------------------+
//|                                           MovingAverage_Test.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"


int indicator_customMA_MN1_1, indicator_customMA_MN1_2,indicator_customMA_D1_1,indicator_customMA_D1_2;
int indicator_customMA_H4_1,indicator_customMA_H4_2,indicator_customMA_H1_1,indicator_customMA_H1_2;
int indicator_customMA_M30_1,indicator_customMA_M30_2,indicator_customMA_M15_1,indicator_customMA_M15_2;
int indicator_customMA_M5_1,indicator_customMA_M5_2;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
    indicator_customMA_H4_1 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_1",8);
   indicator_customMA_H4_2 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_2",14);
   indicator_customMA_H1_1 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_1",8);
   indicator_customMA_H1_2 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_2",14);
   indicator_customMA_M30_1 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_1",8);
   indicator_customMA_M30_2 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_2",14);
   indicator_customMA_M15_1 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_1",8);
   indicator_customMA_M15_2 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_2",14);
   indicator_customMA_M5_1 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_1",8);
   indicator_customMA_M5_2 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_2",14);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   Comment("Status: "+MA_Cross(indicator_customMA_M5_1,indicator_customMA_M5_2));
  }
//+------------------------------------------------------------------+
//| Tester function                                                  |
//+------------------------------------------------------------------+
double OnTester()
  {
//---
   double ret=0.0;
//---

//---
   return(ret);
  }
//+------------------------------------------------------------------+
int MA_Cross(int indicator_customMA_1, int indicator_customMA_2)
  {
   double myMovingAverageArray_lowPer_Cr[];
   double myMovingAverageArray_highPer_Cr[];



   ArraySetAsSeries(myMovingAverageArray_lowPer_Cr, true);
   ArraySetAsSeries(myMovingAverageArray_highPer_Cr, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer_Cr);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer_Cr);
Comment(myMovingAverageArray_lowPer_Cr[1] +" "+myMovingAverageArray_highPer_Cr[1]);
// Crossover bwteen 8-P and 14-P.
   if(myMovingAverageArray_lowPer_Cr[1] > myMovingAverageArray_highPer_Cr[1]
      //&& myMovingAverageArray_lowPer_Cr[2]<myMovingAverageArray_highPer_Cr[2]
     )
     {
      //crossedStatus = 1;
      //Print("Crossed Up Up");


      return 1;

     }
   else
      //   Crossover bwteen 8-P and 14-P.
      if(myMovingAverageArray_lowPer_Cr[1]<myMovingAverageArray_highPer_Cr[1]
         //&& myMovingAverageArray_lowPer_Cr[2]>myMovingAverageArray_highPer_Cr[2]
         )
        {
         //crossedStatus = 0;
         //Print("Crossed Down Down");

         return 0;

        }
      else
        {
         //Print("nOT YET");
         //crossedStatus = -1;
         return -1;
        }
  }
