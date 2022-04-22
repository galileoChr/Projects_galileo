//+------------------------------------------------------------------+
//|                                          TestSupp_Res_Pivots.mq5 |
//|                                  Copyright 2021, Christophe Manzi|
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Christophe Manzi."
#property link      "https://www.mql5.com"
#property version   "1.00"

int indicator_handlePivot_MN1_vis_to_MN1, indicator_handlePivot_MN1_vis_to_D1, indicator_handlePivot_MN1_vis_to_H4;
int indicator_handlePivot_H4_vis_to_M5, indicator_handlePivot_MN1_vis_to_M5, indicator_handlePivot_D1_vis_to_M5;
int indicator_handlePivot_MN1_vis_to_H1, indicator_handlePivot_D1_vis_to_H1, indicator_handlePivot_H4_vis_to_H1;
int indicator_handlePivot_D1_vis_to_D1;

int indicator_handleRetests_H1, indicator_handleRetests_H4, indicator_handleRetests_D1, indicator_handleRetests_MN1 ;

int  indicator_handlePatterns_H4, indicator_handlePatterns_H1;

int indicator_handlePTL_2_M15, indicator_handlePTL_2_H4;

int adx_indicator_handle_H1;

int indicator_customMA_H4_1, indicator_customMA_H4_2, indicator_customMA_H1_1, indicator_customMA_H1_2;
int indicator_customMA_M30_1, indicator_customMA_M30_2, indicator_customMA_M15_1, indicator_customMA_M15_2;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   adx_indicator_handle_H1 = iCustom(Symbol(),PERIOD_H1,"Custom_ADX"
                                    );
   indicator_customMA_H4_1 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_1",8);
   indicator_customMA_H4_2 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_2",14);
   indicator_customMA_H1_1 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_1",8);
   indicator_customMA_H1_2 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_2",14);
//indicator_customMA_M30_1 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_1",8);
//indicator_customMA_M30_2 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_2",14);
//indicator_customMA_M15_1 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_1",8);
//indicator_customMA_M15_2 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_2",14);
//indicator_customMA_M5_1 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_1",8);
//indicator_customMA_M5_2 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_2",14);
//---
//iCustom(Symbol(),PERIOD_W1,"MQLTA MT5 Support Resistance Lines_2");
//indicator_handlePivot_MN1_vis_to_MN1 = iCustom(Symbol(),PERIOD_MN1,"pivot",PERIOD_MN1);
//indicator_handlePivot_MN1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot",PERIOD_MN1);
//indicator_handlePivot_MN1_vis_to_H4 = iCustom(Symbol(),PERIOD_H4,"pivot",PERIOD_MN1);
//indicator_handlePivot_H4_vis_to_M5 = iCustom(Symbol(),PERIOD_M5,"pivot - H4",PERIOD_H4);
//indicator_handlePivot_MN1_vis_to_M5 = iCustom(Symbol(),PERIOD_H4,"pivot - MN1",PERIOD_MN1);
//indicator_handlePivot_D1_vis_to_M5 = iCustom(Symbol(),PERIOD_H4,"pivot - D1",PERIOD_D1);
//indicator_handlePivot_MN1_vis_to_D1 = iCustom(Symbol(),PERIOD_D1,"pivot - MN1",PERIOD_MN1);
//indicator_handlePivot_D1_vis_to_D1 = iCustom(Symbol(),PERIOD_D1,"pivot - D1",PERIOD_D1);
//indicator_handlePivot_MN1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - MN1",PERIOD_MN1);
//indicator_handlePivot_D1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - D1",PERIOD_D1);
//indicator_handlePivot_H4_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - H4",PERIOD_H4);

//indicator_handleRetests_H1 = iCustom(Symbol(),PERIOD_H1,"shved_supply_and_demand_v1.4");

indicator_handleRetests_H1 = iCustom(Symbol(),PERIOD_H1,"shved_supply_and_demand_v1.4");
   //indicator_handleRetests_H4 = iCustom(Symbol(),PERIOD_M5,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_D1 = iCustom(Symbol(),PERIOD_D1,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_MN1 = iCustom(Symbol(),PERIOD_MN1,"shved_supply_and_demand_v1.4");

   indicator_handlePatterns_H4 = iCustom(Symbol(),PERIOD_H4,"patterns_on_chart");
   indicator_handlePatterns_H1 = iCustom(Symbol(),PERIOD_H1,"patterns_on_chart");

//indicator_handlePTL_2_M15 = iCustom(Symbol(),PERIOD_H1,"PTL (2)");
//indicator_handlePTL_2_H4 = iCustom(Symbol(),PERIOD_H4,"PTL (2)");
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


MqlRates rates[];
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  double Ask, Bid;
   Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   ArraySetAsSeries(rates,true);
   CopyRates(Symbol(),PERIOD_M5,0,Bars(Symbol(),PERIOD_M5),rates);

   
//   CopyBuffer(indicator_handleRetests_H4,8,0,5,EntryInfo);

//Comment("FastDnPts: "+FastDnPts[0]+"\n"
//        +"FASTUpPts: "+FastUpPts[0]+"\n"
//        +"SlowDnPts: "+SlowDnPts[0]+"\n"
//        +"SlowUpPts: " +SlowUpPts[0]+"\n");
   //Comment("FastDnPts: "+ner_hi_zone_P1[1]+"\n"
   //        +"FASTUpPts: "+ner_hi_zone_P2[1]+"\n"
   //        +"SlowDnPts: "+ner_lo_zone_P1[1]+"\n"
   //        +"SlowUpPts: " +ner_lo_zone_P2[1]+"\n"+"\n"+
   //        "FastDnPts: "+ner_hi_zone_P1_2[1]+"\n"
   //        +"FASTUpPts: "+ner_hi_zone_P2_2[1]+"\n"
   //        +"SlowDnPts: "+ner_lo_zone_P1_2[1]+"\n"
   //        +"SlowUpPts: " +ner_lo_zone_P2_2[1]+"\n");
   
Comment("Status: "+Supply_Demand_Indicator(indicator_handleRetests_H1,rates));

//Comment();
//Comment("EntryInfo[1]: "+EntryInfo[1]);




  }
//+------------------------------------------------------------------+

// Supply and demand indicator buffers
double FastDnPts[],FastUpPts[];
double SlowDnPts[],SlowUpPts[];

double ner_lo_zone_P1[];
double ner_lo_zone_P2[];
double ner_hi_zone_P1[];
double ner_hi_zone_P2[];
double EntryInfo[];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Supply_Demand_Indicator(int indicator_handleRetests_R, MqlRates &ratesCurr[])
  {
   ArraySetAsSeries(FastDnPts, true);
   ArraySetAsSeries(FastUpPts, true);
   ArraySetAsSeries(SlowDnPts,true);
   ArraySetAsSeries(SlowUpPts,true);

   ArraySetAsSeries(ner_hi_zone_P1,true);
   ArraySetAsSeries(ner_hi_zone_P2,true);
   ArraySetAsSeries(ner_lo_zone_P1,true);
   ArraySetAsSeries(ner_lo_zone_P2,true);
   ArraySetAsSeries(EntryInfo, true);


   CopyBuffer(indicator_handleRetests_R,0,0,5,FastDnPts);
   CopyBuffer(indicator_handleRetests_R,1,0,5,FastUpPts);
   CopyBuffer(indicator_handleRetests_R,2,0,5,SlowDnPts);
   CopyBuffer(indicator_handleRetests_R,3,0,5,SlowUpPts);

   CopyBuffer(indicator_handleRetests_R,4,0,5,ner_hi_zone_P1);// represents higher zone 1st coordinate price
   CopyBuffer(indicator_handleRetests_R,5,0,5,ner_hi_zone_P2);// represents higher zone 2nd coordinate price
   CopyBuffer(indicator_handleRetests_R,6,0,5,ner_lo_zone_P1);// represents lower zone 1st coordinate price
   CopyBuffer(indicator_handleRetests_R,7,0,5,ner_lo_zone_P2);// represents lower zone 2nd coordinate price
//   CopyBuffer(indicator_handleRetests_R,8,0,5,EntryInfo);

// Verify if current rates.Close is in between the box of Supply Demand
   if(ratesCurr[1].close <= ner_lo_zone_P1[1] && ratesCurr[1].close >= ner_lo_zone_P2[1])
     {
     // it is in the lower zone called demand; the code is 0
     return 0;
     }
     if(ratesCurr[1].close >= ner_hi_zone_P1[1] && ratesCurr[1].close <= ner_hi_zone_P2[1])
     {
     // it is in the lower zone called supply; the code is 1
     return 1;
     }else{return -1;}
  }
//+------------------------------------------------------------------+
