//+------------------------------------------------------------------+
//|                                       S_Rind_Testing_Advisor.mq5 |
//|                                  Copyright 2021, Christophe Manzi|
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Christophe Manzi."
#property link      "https://www.mql5.com"
#property version   "1.00"

int indicator_Trending_Angle_H1_1, indicator_Trending_Angle_H4_1, indicator_Trending_Angle_M5_1, indicator_Trending_Angle_M15_1;
int indicator_Trending_Angle_D1_1, indicator_Trending_Angle_MN1_1, indicator_Trending_Angle_M30_1;
int indicator_Trending_Angle_H1_2, indicator_Trending_Angle_H4_2, indicator_Trending_Angle_M5_2, indicator_Trending_Angle_M15_2;
int indicator_Trending_Angle_D1_2, indicator_Trending_Angle_MN1_2, indicator_Trending_Angle_M30_2;



//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   indicator_Trending_Angle_H1_1 = iCustom(Symbol(),PERIOD_H1,"s_rind",4,300,30,70,13.0);
   indicator_Trending_Angle_H1_2 = iCustom(Symbol(),PERIOD_H1,"s_rind_2",8,500,30,70,13.0);
   
   indicator_Trending_Angle_M5_1 = iCustom(Symbol(),PERIOD_M5,"s_rind",4,300,30,70,13.0);
   indicator_Trending_Angle_M5_2 = iCustom(Symbol(),PERIOD_M5,"s_rind_2",8,500,30,70,13.0);

   indicator_Trending_Angle_D1_1 = iCustom(Symbol(),PERIOD_D1,"s_rind_D",4,300,30,70,13.0);
   indicator_Trending_Angle_D1_2 = iCustom(Symbol(),PERIOD_D1,"s_rind_D_2",8,500,30,70,13.0);
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

  }
//+------------------------------------------------------------------+
