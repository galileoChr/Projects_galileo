//+------------------------------------------------------------------+
//|                                           Fibonnacci_Advisor.mq5 |
//|                                  Copyright 2021, Christophe Manzi|
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Christophe Manzi."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>
//#include <generic/hashmap.mqh>
//#include <Dictionary.mqh>
CTrade trade;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
input int not_used = 1;


int adx_indicator_handle, dmi_indicator_handle;
int adx_indicator_handle_MN1, adx_indicator_handle_D1, adx_indicator_handle_H4;
int adx_indicator_handle_H1, adx_indicator_handle_M30, adx_indicator_handle_M15,adx_indicator_handle_M5;
int indicator_handleSupportResistanceL,indicator_handleSupportResistanceL_2,indicator_handleSupportResistanceL_Random;

int indicator_handlePTL_2_MN1, indicator_handlePTL_2_D1, indicator_handlePTL_2_H4, indicator_handlePTL_2_H1;
int indicator_handlePTL_2_M30, indicator_handlePTL_2_M15, indicator_handlePTL_2_M5;

int indicator_handleSupRes, indicator_handleSupRes_MN, indicator_handleSupRes_D1,indicator_handleSupRes_H4;
int indicator_handleSupRes_H1,indicator_handleSupRes_M30, indicator_handleSupRes_M15, indicator_handleSupRes_M5;

int indicator_handlePatterns_MN1, indicator_handlePatterns_D1, indicator_handlePatterns_H4, indicator_handlePatterns_H1;
int indicator_handlePatterns_M30, indicator_handlePatterns_M15, indicator_handlePatterns_M5;

int indicator_handlePivot_MN1_vis_to_MN1, indicator_handlePivot_MN1_vis_to_D1, indicator_handlePivot_MN1_vis_to_H4;
int indicator_handlePivot_H4_vis_to_M5, indicator_handlePivot_MN1_vis_to_M5, indicator_handlePivot_D1_vis_to_M5;
int indicator_handlePivot_MN1_vis_to_H1, indicator_handlePivot_D1_vis_to_H1, indicator_handlePivot_H4_vis_to_H1;
int indicator_handlePivot_D1_vis_to_H4;

int indicator_customMA_MN1_1, indicator_customMA_MN1_2,indicator_customMA_D1_1,indicator_customMA_D1_2;
int indicator_customMA_H4_1,indicator_customMA_H4_2,indicator_customMA_H1_1,indicator_customMA_H1_2;
int indicator_customMA_M30_1,indicator_customMA_M30_2,indicator_customMA_M15_1,indicator_customMA_M15_2;
int indicator_customMA_M5_1,indicator_customMA_M5_2;

int indicator_Trending_Angle_H1_1, indicator_Trending_Angle_H4_1, indicator_Trending_Angle_M5_1, indicator_Trending_Angle_M15_1;
int indicator_Trending_Angle_D1_1, indicator_Trending_Angle_MN1_1, indicator_Trending_Angle_M30_1;
int indicator_Trending_Angle_H1_2, indicator_Trending_Angle_H4_2, indicator_Trending_Angle_M5_2, indicator_Trending_Angle_M15_2;
int indicator_Trending_Angle_D1_2, indicator_Trending_Angle_MN1_2, indicator_Trending_Angle_M30_2;

int indicator_handleRetests_H1, indicator_handleRetests_H4, indicator_handleRetests_D1, indicator_handleRetests_MN1 ;
int indicator_handleRetests_M5, indicator_handleRetests_M15, indicator_handleRetests_M30;



int indicator_Fibonacci_D1, indicator_Fibonacci_H4, indicator_Fibonacci_H1, indicator_Fibonacci_M30;
int indicator_Fibonacci_M15, indicator_Fibonacci_M5;

int indicator_Stochastci_H1;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//indicator_Fibonacci_H1 = iCustom(Symbol(),PERIOD_H1,"fibos"); // "fibo_retrace" or "PZ_Fibonacci" or "fibos"
//indicator_Fibonacci_H4 = iCustom(Symbol(),PERIOD_H4,"fibos"); // "fibo_retrace" or "PZ_Fibonacci" or "fibos"
   indicator_Fibonacci_M5 = iCustom(Symbol(),PERIOD_M5,"fibos",100); // "fibo_retrace" or "PZ_Fibonacci" or "fibos"

//indicator_Stochastci_H1 = iCustom(Symbol(),PERIOD_H1,"Stochastic"
//                                 );

//adx_indicator_handle_H1 = iCustom(Symbol(),PERIOD_H1,"Custom_ADX"
//                                 );
//adx_indicator_handle_D1 = iCustom(Symbol(),PERIOD_D1,"Custom_ADX"
//                                 );
//adx_indicator_handle_H4 = iCustom(Symbol(),PERIOD_H4,"Custom_ADX"
//                                 );
//adx_indicator_handle_M5 = iCustom(Symbol(),PERIOD_M5,"Custom_ADX"
//                                 );
   indicator_customMA_D1_1 = iCustom(Symbol(),PERIOD_D1,"Custom Moving Average_1",8);
   indicator_customMA_D1_2 = iCustom(Symbol(),PERIOD_D1,"Custom Moving Average_2",50);
   indicator_customMA_H4_1 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_1",8);
   indicator_customMA_H4_2 = iCustom(Symbol(),PERIOD_H4,"Custom Moving Average_2",14);
   indicator_customMA_H1_1 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_1",8);
   indicator_customMA_H1_2 = iCustom(Symbol(),PERIOD_H1,"Custom Moving Average_2",50);
   indicator_customMA_M30_1 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_1",8);
   indicator_customMA_M30_2 = iCustom(Symbol(),PERIOD_M30,"Custom Moving Average_2",50);
   indicator_customMA_M15_1 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_1",8);
   indicator_customMA_M15_2 = iCustom(Symbol(),PERIOD_M15,"Custom Moving Average_2",50);
   indicator_customMA_M5_1 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_1",8);
   indicator_customMA_M5_2 = iCustom(Symbol(),PERIOD_M5,"Custom Moving Average_2",50);

//iCustom(Symbol(),PERIOD_W1,"MQLTA MT5 Support Resistance Lines_2");
//indicator_handlePivot_MN1_vis_to_MN1 = iCustom(Symbol(),PERIOD_MN1,"pivot",PERIOD_MN1);
//indicator_handlePivot_MN1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot",PERIOD_MN1);
//indicator_handlePivot_MN1_vis_to_H4 = iCustom(Symbol(),PERIOD_H4,"pivot",PERIOD_MN1);

   indicator_handlePivot_H4_vis_to_M5 = iCustom(Symbol(),PERIOD_M5,"pivot - H4",PERIOD_H4);
   indicator_handlePivot_MN1_vis_to_M5 = iCustom(Symbol(),PERIOD_M5,"pivot - MN1",PERIOD_MN1);
   indicator_handlePivot_D1_vis_to_M5 = iCustom(Symbol(),PERIOD_M5,"pivot - D1",PERIOD_D1);
//indicator_handlePivot_MN1_vis_to_D1 = iCustom(Symbol(),PERIOD_D1,"pivot - MN1",PERIOD_MN1);
   indicator_handlePivot_MN1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - MN1",PERIOD_MN1);
   indicator_handlePivot_D1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - D1",PERIOD_D1);
//indicator_handlePivot_H4_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - H4",PERIOD_H4);
//indicator_handlePivot_D1_vis_to_H4 = iCustom(Symbol(),PERIOD_H4,"pivot - D1",PERIOD_D1);

//indicator_handlePTL_2_H1 = iCustom(Symbol(),PERIOD_H1,"PTL (2)");
//indicator_handlePTL_2_M5 = iCustom(Symbol(),PERIOD_M5,"PTL (2)");
//indicator_handlePTL_2_M15 = iCustom(Symbol(),PERIOD_M15,"PTL (2)");
//indicator_handlePTL_2_H1 = iCustom(Symbol(),PERIOD_H1,"PTL (2)");
//indicator_handlePTL_2_H4 = iCustom(Symbol(),PERIOD_H4,"PTL (2)");
//indicator_handlePTL_2_D1 = iCustom(Symbol(),PERIOD_D1,"PTL (2)");


   indicator_handleSupRes_H4 =iCustom(Symbol(),PERIOD_H4,"Support_and_Resistance");
   indicator_handleSupRes_D1 = iCustom(Symbol(),PERIOD_D1,"Support_and_Resistance");
   indicator_handleSupRes_H1 = iCustom(Symbol(),PERIOD_H1,"Support_and_Resistance");
   indicator_handleSupRes_MN = iCustom(Symbol(),PERIOD_MN1,"Support_and_Resistance");
   indicator_handleSupRes_M5 = iCustom(Symbol(),PERIOD_M5,"Support_and_Resistance");
   indicator_handleSupRes_M15 = iCustom(Symbol(),PERIOD_M15,"Support_and_Resistance");

   indicator_handlePatterns_H4 = iCustom(Symbol(),PERIOD_H4,"patterns_on_chart");
//indicator_handlePatterns_D1 = iCustom(Symbol(),PERIOD_D1,"patterns_on_chart");
   indicator_handlePatterns_H1 = iCustom(Symbol(),PERIOD_H1,"patterns_on_chart");
//indicator_handlePatterns_MN1 = iCustom(Symbol(),PERIOD_MN1,"patterns_on_chart");
//indicator_handlePatterns_M5 = iCustom(Symbol(),PERIOD_M5,"patterns_on_chart");
//indicator_handlePatterns_M15 = iCustom(Symbol(),PERIOD_M15,"patterns_on_chart");
//indicator_handlePatterns_M30 = iCustom(Symbol(),PERIOD_M30,"patterns_on_chart");
//iCustom(Symbol(),PERIOD_M5,"patterns_on_chart");


//indicator_handleRetests_M5 = iCustom(Symbol(),PERIOD_M5,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_H1 = iCustom(Symbol(),PERIOD_H1,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_H4 = iCustom(Symbol(),PERIOD_H4,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_D1 = iCustom(Symbol(),PERIOD_D1,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_MN1 = iCustom(Symbol(),PERIOD_MN1,"shved_supply_and_demand_v1.4");


//indicator_Trending_Angle_H1_1 = iCustom(Symbol(),PERIOD_H1,"s_rind_D",2,300,30,70,13.0); // "s_rind" or "autotrendlines"
//indicator_Trending_Angle_H1_2 = iCustom(Symbol(),PERIOD_H1,"s_rind_D_2",8,500,30,70,13.0);

//indicator_Trending_Angle_M5_1 = iCustom(Symbol(),PERIOD_M5,"s_rind_D",4,300,30,70,13.0);
//indicator_Trending_Angle_M5_2 = iCustom(Symbol(),PERIOD_M5,"s_rind_2",2,500,30,70,13.0);

//indicator_Trending_Angle_H4_1 = iCustom(Symbol(),PERIOD_H4,"s_rind_D",2,300,30,70,13.0);
//indicator_Trending_Angle_H4_2 = iCustom(Symbol(),PERIOD_H4,"s_rind_2",8,500,30,70,13.0);

//indicator_Trending_Angle_D1_1 = iCustom(Symbol(),PERIOD_D1,"s_rind_D",4,300,30,70,13.0);
//indicator_Trending_Angle_D1_2 = iCustom(Symbol(),PERIOD_D1,"s_rind_D_2",8,500,30,70,13.0);

//indicator_Trending_Angle_MN1_1 = iCustom(Symbol(),PERIOD_MN1,"s_rind_D",4,300,30,70,13.0);
//indicator_Trending_Angle_MN_2 = iCustom(Symbol(),PERIOD_MN1,"s_rind_D_2",8,500,30,70,13.0);


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
double Ask, Bid;
int strategyNum_0 = -1;
int strategyNum_10101 = -1;
int strategyNum_10101_Initializer = -1;
double PivotBufferPrices_MN1[7];
double PivotBufferPrices_D1[7];
double PivotBufferPrices_H4[7];
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

//---
// Update the EA at every period below:

   if(CheckNewBar(PERIOD_M5) != 1)
     {}
   else
     {


      ArraySetAsSeries(rates,true);
      CopyRates(Symbol(),PERIOD_M5,0,Bars(Symbol(),PERIOD_M5),rates);

      Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
      Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
      ArraySetAsSeries(rates,true);
      CopyRates(Symbol(),PERIOD_M5,0,Bars(Symbol(),PERIOD_M5),rates);





      int Fibs = Fibonacci_Status(indicator_Fibonacci_H1,PERIOD_H1);


      double Resi_Zone_H1 = Support_Resistance_Zones_Sell(indicator_handleSupRes_H1,1);
      double Supp_Zone_H1 = Support_Resistance_Zones_Buy(indicator_handleSupRes_H1,1);

      double Resi_Zone_M5 = Support_Resistance_Zones_Sell(indicator_handleSupRes_M15,1);
      double Supp_Zone_M5 = Support_Resistance_Zones_Buy(indicator_handleSupRes_M15,1);




      int randNumber = 3 + 3*MathRand()/32768; // 3-5


      // DEFINE Break of structure of trendlines
      int BreakStruc_TrendLine_H1 = BreakStructureTrendline(indicator_Trending_Angle_H1_1,PERIOD_H1);
      int BreakStruc_TrendLine_M5 = BreakStructureTrendline(indicator_Trending_Angle_M5_1,PERIOD_M5);



      // Trendline price action: try to predict retracement points using trendlines prices
      int TrendLine_PriceAction_M5 = TrendLine_PriceAction(indicator_Trending_Angle_M5_1,PERIOD_M5);





      //Comment("trendline Price ActionM5: "+TrendLine_PriceAction_M5);

      // Imperfect indicators are stronger together. Apes strong together. Direction of market:
      int ADX_status_H1 = Market_Structure(adx_indicator_handle_H1,PERIOD_H1);
      int DI_status_H1 = Market_Structure_2(adx_indicator_handle_H1,PERIOD_H1);
      int MA_PriceAction_Status_H1 = MA_PriceAction(indicator_customMA_H1_1,indicator_customMA_H1_2,PERIOD_H1);
      int trendline_status_H1 = TrendLine_Status(indicator_Trending_Angle_H1_1,PERIOD_H1,rates);

      int MarketDir_H1 = Market_Direction(ADX_status_H1,DI_status_H1,MA_PriceAction_Status_H1,trendline_status_H1);


      // H4 Version, which less volatile
      int ADX_status_H4 = Market_Structure(adx_indicator_handle_H4,PERIOD_H4);
      int DI_status_H4 = Market_Structure_2(adx_indicator_handle_H4,PERIOD_H4);
      int MA_PriceAction_Status_H4 = MA_PriceAction(indicator_customMA_H4_1,indicator_customMA_H4_2,PERIOD_H4);
      int trendline_status_H4 = TrendLine_Status(indicator_Trending_Angle_H4_1,PERIOD_H4,rates);

      int MarketDir_H4 = Market_Direction(ADX_status_H4,DI_status_H4,MA_PriceAction_Status_H4,trendline_status_H4);



      // Delay the entry by wainting for price to be above/below MA of M5 (SAFE SIDE TEST)
      int MA_PriceAction_Status_M5 = MA_PriceAction(indicator_customMA_M5_1,indicator_customMA_M5_2,PERIOD_M5);
      int trendLine_PriceAction_delay = DelayEntry_TrendLine_PriceAction(TrendLine_PriceAction_M5,MA_PriceAction_Status_M5,MarketDir_H1);


      // M5 Version, which less volatile
      int ADX_status_M5 = Market_Structure(adx_indicator_handle_M5,PERIOD_M5);
      int DI_status_M5 = Market_Structure_2(adx_indicator_handle_M5,PERIOD_M5);
      int trendline_status_M5 = TrendLine_Status(indicator_Trending_Angle_M5_1,PERIOD_M5,rates);

      int MarketDir_M5 = Market_Direction(ADX_status_M5,DI_status_M5,MA_PriceAction_Status_M5,trendline_status_M5);


      // Strategy Num1 test:
      int strategyNum_1 =  strategyNum1(trendLine_PriceAction_delay,MarketDir_H4,Fibs);
      //      Comment("strat1: "+IntegerToString(strategyNum_1)
      //              +"\nMarketDir_H1: "+MarketDir_H1
      //              +"\nMarketDir_H4: "+MarketDir_H4
      //              +"\nMarketDir_M5: "+MarketDir_M5
      //              +"\nMA_PRICE_M5: "+MA_PriceAction_Status_M5
      //              +"\nTrendLine_priceAction: "+TrendLine_PriceAction_M5
      //              +"nTrendLine_priceAction Delay vers: "+trendLine_PriceAction_delay);



      for(int i=0; i<7; i++)
        {
         PivotBufferPrices_MN1[i] = PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_MN1,i);
         PivotBufferPrices_D1[i] = PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,i);
         PivotBufferPrices_H4[i] = PivotBufferPrices(indicator_handlePivot_H4_vis_to_M5,PERIOD_H4,i);
        }






      // Strategy Number 2:
      int strategyNum_2 = strategyNum2(MA_Prices_Return(indicator_customMA_H4_1,indicator_customMA_H4_2,PERIOD_H4,1)
                                       ,MA_Cross(indicator_customMA_H4_1,indicator_customMA_H4_2),
                                       MA_PriceAction(indicator_customMA_H4_1,indicator_customMA_H4_2,PERIOD_H4),PERIOD_H4);



      // This method makes sure that each symbol used has its own inputs...
      Right_Placing_Inputs();

      strategyNum_0 = strategyNum_000000(MA_Cross_Continuous(indicator_customMA_H4_1,indicator_customMA_H4_2)
                                         ,MA_PriceAction(indicator_customMA_H1_1,indicator_customMA_H1_2,PERIOD_H1),rates);

      //      Print("not Used: "+not_used);
      if(OrdersTotal() == 0 && strat_1010101_Input == -1)
        {
         double HighSideDiff = MathAbs(rates[1].close - Lower_Higher_Support_Resistance(PivotBufferPrices_MN1,1,rates));
         double LowSideDiff =   MathAbs(rates[1].close - Lower_Higher_Support_Resistance(PivotBufferPrices_MN1,0,rates));
         if(HighSideDiff > LowSideDiff)
           {
            strategyNum_10101 = 0;
           }
         else
           {
            strategyNum_10101 = 1;
           }


        }
      else
        {
         strategyNum_10101 =  strategyNum_1010101010(Lower_Higher_Support_Resistance(PivotBufferPrices_MN1,1,rates),
                              Lower_Higher_Support_Resistance(PivotBufferPrices_MN1,0,rates),
                              PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5,0),
                              PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5,1),
                              PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5,2),
                              PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5,3),
                              PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5,4),
                              PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5,5),
                              PivotBufferPrices(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5,6),

                              MA_PriceAction(indicator_customMA_H1_1,indicator_customMA_H1_2,PERIOD_H1), rates);
        }



      //strategyNum_10101_Initializer =

      // Strategy Number 3:
      int strategyNum_3 = strategyNum3(MA_Cross_Continuous(indicator_customMA_H4_1,indicator_customMA_H4_2)
                                       ,MA_Cross(indicator_customMA_M5_1,indicator_customMA_M5_2));


      Comment("Strat#10101: "+IntegerToString(strategyNum_10101));
      Print("Strat#10101: "+strategyNum_10101);




      if(strategyNum_10101 == 1)
        {
         if(PositionSelect(Symbol()) == false)
           {

            // Test DCA Risk management
            DCA_RiskTrade_Breakdown_v2(1.25,(Ask - 800*_Point),Ask + 10*_Point,Ask,1,"strat_0 Buy",1);
            //minute_Counter_3 = 0;


            allow_Patch = false;

           }
         Take_Profit_Renew(TP_AdditionalPoints,1);
        }
      else
         if(strategyNum_10101 == 0)
           {
            if(PositionSelect(Symbol()) == false)
              {

               // Test DCA Risk management

               DCA_RiskTrade_Breakdown_v2(1.25,(Ask - 800*_Point),Ask + 10*_Point,Ask,0,"strat_0 Buy",1); // ranging: 1 ; trending: -1
              }
            Take_Profit_Renew(TP_AdditionalPoints,0);

           }





      Print("Points : "+Points_Converter(250));// 400 POINTS on AUD/USD is 40000 points on BTC/US


      if(minute_Counter_3 == 3)
        {
         // COunts after one hour has passed
         minute_Counter_3 = 0;
        }

      minute_Counter_3 +=1;



      Print("Minute Counter: "+minute_Counter_3);


     }// M5 Candlestick later .....

   if(PositionsTotal() > 0)
     {
      Check_Buy_Sell_Positions();
     }




// This puts a timer after an order has been cast. If after 2*5 = 10min no positions, then delete the orders.

   if(PositionSelect(Symbol()) == false && minute_Counter_3 == 2)
     {
      Delete_All_Orders("strat_0 Buy");


     }

   DCA_Trades_Fulfilled("strat_0 Buy");






  }
  // Symbols
string AU = "AUDUSD";
string GU = "GBPUSD";
string UJ = "USDJPY";
string EU = "EURUSD";
string BTCUSD = "BTCUSD";
string GOLD = "XAUUSD";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Check_Buy_Sell_Positions()
  {


   if(PositionGetInteger(POSITION_TYPE) == 0)// Check for BUY positions
     {
      Take_Profit_Renew(TP_AdditionalPoints,1);
     }

   if(PositionGetInteger(POSITION_TYPE) == 1) // Check for SELL positions
     {
      Take_Profit_Renew(TP_AdditionalPoints,0);
     }


  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Take_Profit_Renew(double TP_Additional_Points, int Buy_Or_Sell)
  {
   double average_new_TP = 0;
   double sum_TP = 0;
   double average_TP_Array[210];
//sum_TP += usual_TP;
//ArrayResize(average_TP_Array,120);
   if(Buy_Or_Sell == 1)
     {

      for(int i=0; i<PositionsTotal(); i++)
        {

         average_TP_Array[i] = PositionGetDouble(POSITION_PRICE_OPEN) + TP_Additional_Points*_Point;
         sum_TP += average_TP_Array[i];
         //Print("TP SSSSSS: ");
         //ArrayPrint(average_TP_Array);

         //average_new_TP += PositionGetDouble(POSITION_TP)/PositionsTotal();
         // get ticket number
         ulong PositionTicket = PositionGetTicket(i);



        }
     }

   if(Buy_Or_Sell == 0)
     {

      for(int i=0; i<PositionsTotal(); i++)
        {

         average_TP_Array[i] = PositionGetDouble(POSITION_PRICE_OPEN) - TP_Additional_Points*_Point;
         sum_TP += average_TP_Array[i];
         //Print("TP SSSSSS: ");
         //ArrayPrint(average_TP_Array);

         //average_new_TP += PositionGetDouble(POSITION_TP)/PositionsTotal();
         // get ticket number
         ulong PositionTicket = PositionGetTicket(i);



        }
     }


//Print("Length of array Positions: "+ArraySize(average_TP_Array)+" posit. Total: "+PositionsTotal());
   if(PositionsTotal() > 0)
     {
      average_new_TP = sum_TP/PositionsTotal();
      //Print("TP average: "+average_new_TP);
     }
   else
     {

      //Print("TP average: "+average_new_TP);
     }
   for(int i=0; i<PositionsTotal(); i++)
     {
      // get ticket number
      ulong PositionTicket = PositionGetTicket(i);



      trade.PositionModify(PositionTicket,0,average_new_TP);



     }

   return 0;
  }


//+------------------------------------------------------------------+
//| This method makes sure that each symbol used has its own inputs...
//+------------------------------------------------------------------+
void Right_Placing_Inputs()
  {
   if(Symbol() == "AUDUSD")
     {
     // Reference
      // 10k: 52, 200, 0.03 ; 100k: 52, 20, 0.03
      TP_AdditionalPoints = 30; // From AUDUSD standPoint;
      Trades_Increment_Step =  100; // From AUDUSD standPoint;
      Volume_Chosen = 0.03; // From AUDUSD standPoint;
     }
   else
      if(Symbol() == "BTCUSD")
        {
         TP_AdditionalPoints = 9*21013;
         Trades_Increment_Step = 10*8405;
         Volume_Chosen = 0.03;
        }
      else
         if(Symbol() == "BTCEUR")
           {
            TP_AdditionalPoints = 9*21013;
            Trades_Increment_Step = 10*8405;
            Volume_Chosen = 0.1;
           }
         else
            if(Symbol() == "EURUSD")
              {
               TP_AdditionalPoints = 30;
               Trades_Increment_Step = 100;
               Volume_Chosen = 0.03;
              }
            else
               if(Symbol() == "GBPUSD")
                 {
                  TP_AdditionalPoints = 30;
                  Trades_Increment_Step = 100;
                  Volume_Chosen = 0.03;
                 }
               else
                 {
                  TP_AdditionalPoints = 30;
                  Trades_Increment_Step = 100;
                  Volume_Chosen = 0.03;
                 }
  }


double testingSum = 0;

int minute_Counter_3 = 0;
int triggeredTP = -1;
double Trading_Patches_Prices[10];
int patches_counter = 0;
bool allow_Patch = false;


double TP_AdditionalPoints = 25; // From AUDUSD standPoint;
double Trades_Increment_Step = 10; // From AUDUSD standPoint;
double Volume_Chosen = 0.03; // From AUDUSD standPoint;
//+------------------------------------------------------------------+
//This method ensures the Dollar Cost Average limits our risk from a trade.
//
//Enter the amount of funds your Safety Orders will use to Average the cost
//of the asset being traded, this can help your bot to close deals faster
//with more profit. Safety Orders are also known as Dollar Cost Averaging
//and help when prices moves in the opposite direction to your bot's take profit target.")
//+------------------------------------------------------------------+
int DCA_RiskTrade_Breakdown_v2(double volume_PreviouslyRequired, double Stop_Loss, double Take_Profit, double Ask_Price, int Buy_Or_Sell, string comment_strat, int ranging_Or_trending)
  {

   triggeredTP = -1;


   double decimal_places = 2;
   double number_Of_Trades = 17;
   double desired_Total_Lots = 1;
   double Volume_Scale = desired_Total_Lots*(0.02/8.9);
   double sum_lots_bUY = 0.01;
   if(Buy_Or_Sell == 1 && (OrdersTotal() < number_Of_Trades-2 || OrdersTotal() == 0))
     {
      if(ranging_Or_trending == 1) // Ranging
        {
         for(int i=0; i<=number_Of_Trades; i++)
           {



            // The 0.01 lot strategy is very effective, it can start small, but man it can get big..
            trade.BuyLimit(Volume_Chosen,Ask_Price - i*Trades_Increment_Step*_Point,Symbol(),
                           0,Ask_Price - i*Trades_Increment_Step*_Point + i*TP_AdditionalPoints*_Point,0,0,comment_strat);





           }
        }
      if(ranging_Or_trending == -1) // Trending
        {
         for(int i=0; i<=number_Of_Trades; i++)
           {



            // The 0.01 lot strategy is very effective, it can start small, but man it can get big..
            trade.BuyLimit(Volume_Chosen,Ask_Price + i*Trades_Increment_Step*_Point,Symbol(),
                           0,Ask_Price + i*Trades_Increment_Step*_Point + i*TP_AdditionalPoints*_Point,0,0,comment_strat);





           }
        }




     }

   double sum_lots_sELL = 0.01;

   if(Buy_Or_Sell == 0 && (OrdersTotal() < number_Of_Trades-2 || OrdersTotal() == 0))
     {

      if(ranging_Or_trending == 1) // Ranging
        {
         for(int i=0; i<=number_Of_Trades; i++)
           {

            // The 0.01 lot strategy is very effective, it can start small, but man it can get big..
            trade.SellLimit(Volume_Chosen,Ask_Price + i*Trades_Increment_Step*_Point,Symbol(),
                            0,Ask_Price + i*Trades_Increment_Step*_Point - TP_AdditionalPoints*_Point,0,0,comment_strat);


           }
        }

      if(ranging_Or_trending == -1) // Trending
        {
         for(int i=0; i<=number_Of_Trades; i++)
           {

            // The 0.01 lot strategy is very effective, it can start small, but man it can get big..
            trade.SellLimit(Volume_Chosen,Ask_Price - i*Trades_Increment_Step*_Point,Symbol(),
                            0,Ask_Price - i*Trades_Increment_Step*_Point - TP_AdditionalPoints*_Point,0,0,comment_strat);


           }
        }

     }



//step_review(Ask_Price);





   return -1;
  }

bool allowed = true;
double Initial_Price_Buy = 0;
double Initial_Price_Sell = 0;
//+------------------------------------------------------------------+
//|This way of trading is from crypto bots, which makes money by creating a grid
//|that moves with price. There are sell limits above price and buy limits below price.
//|First task, we created a moving grid of limit orders.
//+------------------------------------------------------------------+
double DCA_Grid_Bots(double Ask_Price, int Buy_Or_Sell, string comment_strat)
  {
   int numberOfOrders = 10;
   double Possible_TradesSell[200];
   double Possible_TradesBuy[200];
   double Last_Position_Opened_Price = Get_Last_PositionTradePrice_Open();
   double First_Position_Opened_Price = Get_First_PositionTradePrice_Open();
   Print("First Positn: "+First_Position_Opened_Price);

//Print("Number of orders: "+numberOfOrders);

   double currPrice = rates[0].close;
   double UpperLimitPrice = Ask_Price + numberOfOrders*Trades_Increment_Step*_Point;
   double LowerLimitPrice = Ask_Price - numberOfOrders*Trades_Increment_Step*_Point;

//Print("Low limit: "+LowerLimitPrice + " Upper limit: "+UpperLimitPrice);

   if(allowed == true)
     {
      Initial_Price_Buy = Ask_Price;
      Initial_Price_Sell = Ask_Price+Trades_Increment_Step*_Point;
      allowed = false;
     }


//if(OrdersTotal() == 0 || PositionsTotal() == 0)
//  {
   if(Ask_Price > (Initial_Price_Buy))
     {
      Delete_All_Orders("grid_Buy strat");

      // These are orders that get renewed.
      for(int i=1; i<numberOfOrders; i++)
        {

         trade.BuyLimit(Volume_Chosen,Ask_Price - i*Trades_Increment_Step*_Point,Symbol(),
                        0,Ask_Price - i*Trades_Increment_Step*_Point + Trades_Increment_Step*_Point,0,0,"grid_Buy strat");

         //trade.SellLimit(Volume_Chosen,Ask_Price + i*Trades_Increment_Step*_Point,Symbol(),
         //                0,Ask_Price + i*Trades_Increment_Step*_Point - Trades_Increment_Step*_Point,0,0,"grid_Sell strat");


        }
      //allowed = true;

     }
   else
     {
      Initial_Price_Buy = Last_Position_Opened_Price;
      //Initial_Price_Sell = First_Position_Opened_Price;
      //Delete_All_Orders("grid_Sell strat");


     }

//}






//if(Orders_Or_Positions_Present(Ask_Price - Trades_Increment_Step*_Point, Ask_Price) == false)
//  {
//   trade.BuyLimit(Volume_Chosen,Ask_Price - Trades_Increment_Step*_Point,Symbol(),
//                  0,Ask_Price - Trades_Increment_Step*_Point + Trades_Increment_Step*_Point,0,0,"vict...");
//  }


//if(Orders_Or_Positions_Present(Ask_Price + Trades_Increment_Step*_Point, Ask_Price) == false)
//  {
//   trade.SellLimit(Volume_Chosen,Ask_Price + Trades_Increment_Step*_Point,Symbol(),
//                   0,Ask_Price + Trades_Increment_Step*_Point - Trades_Increment_Step*_Point,0,0,"vict...sell");
//  }

//for(int i=0; i<200; i++)
//  {
//   if(LowerLimitPrice < Possible_TradesBuy[i])
//     {
//      if(Orders_Or_Positions_Present(Possible_TradesBuy[i]) == false)
//        {
//         trade.BuyLimit(Volume_Chosen,Possible_TradesBuy[i],Symbol(),
//                        0,Possible_TradesBuy[i] + Trades_Increment_Step*_Point,0,0,"vict...");
//        }
//     }
//  }



   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Orders_Or_Positions_Present(double priceTrading, double priceTrading_TP)
  {
   int DecimalPlaces = 5;
   priceTrading = NormalizeDouble(priceTrading,DecimalPlaces);
   for(int i=0; i<OrdersTotal(); i++)
     {

      // get ticket number
      ulong OrderTicket = NormalizeDouble(OrderGetTicket(i),DecimalPlaces);
      double OrderPrice = NormalizeDouble(OrderGetDouble(ORDER_PRICE_OPEN),DecimalPlaces);
      double OrderTP = NormalizeDouble(OrderGetDouble(ORDER_TP),DecimalPlaces);

      if(priceTrading <= OrderPrice  || priceTrading_TP == OrderTP)
        {
         return true;
        }





     }

   for(int i=0; i<PositionsTotal(); i++)
     {

      // get ticket number
      ulong PositionTicket = NormalizeDouble(PositionGetTicket(i),DecimalPlaces);

      double PositionPrice = NormalizeDouble(PositionGetDouble(POSITION_PRICE_OPEN),DecimalPlaces);
      double PositionTP = NormalizeDouble(PositionGetDouble(POSITION_TP),DecimalPlaces);

      if(priceTrading == PositionPrice || priceTrading_TP == PositionTP)
        {
         return true;
        }

     }

   return false;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Get_Last_PositionTradePrice_Open()
  {
   for(int i=0; i<PositionsTotal(); i++)
     {
      int DecimalPlaces = 5;
      // get ticket number
      ulong PositionTicket = NormalizeDouble(PositionGetTicket(i),DecimalPlaces);

      double PositionPrice = NormalizeDouble(PositionGetDouble(POSITION_PRICE_OPEN),DecimalPlaces);
      double PositionTP = NormalizeDouble(PositionGetDouble(POSITION_TP),DecimalPlaces);

      if(i == PositionsTotal() - 1)
        {
         return PositionPrice;
        }

     }

   return -1;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Get_First_PositionTradePrice_Open()
  {
   for(int i=0; i<PositionsTotal(); i++)
     {
      int DecimalPlaces = 5;
      // get ticket number
      ulong PositionTicket = NormalizeDouble(PositionGetTicket(i),DecimalPlaces);

      double PositionPrice = NormalizeDouble(PositionGetDouble(POSITION_PRICE_OPEN),DecimalPlaces);
      double PositionTP = NormalizeDouble(PositionGetDouble(POSITION_TP),DecimalPlaces);

      if(i == 0)
        {
         return PositionPrice;
        }

     }

   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Cancel_Add_OffGrid_Orders(double out_of_area_Step, double lower_limit_OrderPrice,  double upper_limit_OrderPrice)
  {
// when price has reached the limit ...
   if(rates[0].close >= upper_limit_OrderPrice || rates[0].close <= lower_limit_OrderPrice)
     {
      Print("Limit reached !!!");
      for(int i=0; i<OrdersTotal(); i++)
        {

         // get ticket number
         ulong OrderTicket = OrderGetTicket(i);
         double Order_PriceOpen =  OrderGetDouble(ORDER_PRICE_OPEN);

         // Delete upper limits when price has reached the lower limit of the grid
         if(Order_PriceOpen > (rates[0].close + out_of_area_Step))
           {
            trade.OrderDelete(OrderTicket);

            trade.BuyLimit(Volume_Chosen,Order_PriceOpen - Trades_Increment_Step*_Point,Symbol(),
                           0,Order_PriceOpen - Trades_Increment_Step*_Point + TP_AdditionalPoints*_Point,0,0,"Recycled strat#00");
           }
         // Delete lower limits when price has reached the upper the limit of the grid
         if(Order_PriceOpen < (rates[0].close - out_of_area_Step))
           {
            trade.OrderDelete(OrderTicket);
            trade.SellLimit(Volume_Chosen,Order_PriceOpen + Trades_Increment_Step*_Point,Symbol(),
                            0,Order_PriceOpen + Trades_Increment_Step*_Point - TP_AdditionalPoints*_Point,0,0,"Recycled strat#00");
           }





        }
     }

  }

//+------------------------------------------------------------------+
bool redeemer_Activate = true;
double Crypto_Interval_Web_Zone[2];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Crypto_DCA_Strat(double Ask_Price, int Buy_Or_Sell, string comment_strat)
  {

   double TP_AdditionalPoints = 25; // From AUDUSD standPoint;
   double Trades_Increment_Step = 12405; // From BTCUSD standPoint;
   if(Symbol() == "BTCUSD" || Symbol() == "BTCEUR")
     {
      TP_AdditionalPoints = 21013;
     }
//triggeredTP = -1;


   double decimal_places = 2;
//Delete_All_Orders("mm");
   double sum_lots_bUY = 0.01;
//if(Buy_Or_Sell == 1)
//  {
   for(int i=0; i<=50; i++)
     {
      //sum_lots_bUY += NormalizeDouble(sum_lots_bUY,decimal_places);

      if(Refill_Trades_Crypto_Orders(Ask_Price,i*Trades_Increment_Step) == true &&
         Refill_Trades_Crypto_Positions(Ask_Price - i*Trades_Increment_Step*_Point) == true)
        {
         trade.BuyLimit(0.03,Ask_Price - i*Trades_Increment_Step*_Point,Symbol(),
                        0,Ask_Price - i*Trades_Increment_Step*_Point + 21000*_Point,0,0,comment_strat);
        }




     }
   Crypto_Interval_Web_Zone[1] = Ask_Price - 50*Trades_Increment_Step*_Point;
   for(int i=0; i<=50; i++)
     {
      //sum_lots_bUY += NormalizeDouble(sum_lots_bUY,decimal_places);

      if(Refill_Trades_Crypto_Orders(Ask_Price,i*Trades_Increment_Step) == true
         && Refill_Trades_Crypto_Positions(Ask_Price - i*Trades_Increment_Step*_Point) == true)
        {
         trade.BuyLimit(0.03,Ask_Price + i*Trades_Increment_Step*_Point,Symbol(),
                        0,Ask_Price + i*Trades_Increment_Step*_Point + 21000*_Point,0,0,comment_strat);
        }


     }
   Crypto_Interval_Web_Zone[0] = Ask_Price + 50*Trades_Increment_Step*_Point;
//}
   double sum_lots_sELL = 0.01;
//   if(Buy_Or_Sell == 0)
//     {
//      for(int i=0; i<=10; i++)
//        {
//         if(i>=4)
//           {
//            sum_lots_sELL += NormalizeDouble(sum_lots_sELL*MathPow(1.80,1),decimal_places);
//           }
//         else
//           {
//            sum_lots_sELL += NormalizeDouble(sum_lots_sELL*MathPow(1.19,i),decimal_places);
//           }
//         // Prevents any order of the same volume to be cast in the web.
//         if(volume_Already_Exists(sum_lots_sELL) == false)
//           {
//
//            trade.SellLimit(sum_lots_sELL,Trade_Price(Ask_Price,i,0),Symbol(),
//                            0,Trade_Price(Ask_Price,i,0) - TP_AdditionalPoints*_Point*MathPow(1.12,i),0,0,comment_strat);
//           }
//
//        }
//     }


  }

//+------------------------------------------------------------------+
//|This method makes sure that orders that are not in the zome are deleted.
//+------------------------------------------------------------------+
void DCA_Crypto_Fulfilled(double &Orders_Interval_Values[])
  {

   for(int i=0; i<OrdersTotal(); i++)
     {
      // get ticket number
      ulong OrderTicket = OrderGetTicket(i);

      double Order_PriceOpen = OrderGetDouble(ORDER_PRICE_OPEN);
      // 0 ==> Upper value and 1 ==> lower value;
      if(Order_PriceOpen > Orders_Interval_Values[0] || Order_PriceOpen < Orders_Interval_Values[1])
        {
         trade.OrderDelete(OrderTicket);
        }



     }

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Refill_Trades_Crypto_Orders(double trading_Price, double spaceWindow_nextTradePrice)
  {
   for(int i=0; i<OrdersTotal(); i++)
     {
      //if(strategy_comment == OrderGetString(POSITION_COMMENT))
      //  {
      // get ticket number
      ulong OrderTicket = OrderGetTicket(i);
      double OrderPrice = OrderGetDouble(ORDER_PRICE_OPEN);
      //Print("Order Price vs tradinPrice: "+OrderPrice+" ticket: "+OrderTicket+"  vs  "+trading_Price);
      //if((OrderPrice < (trading_Price + spaceWindow_nextTradePrice*_Point) && (OrderPrice > trading_Price))
      //   || (OrderPrice > (trading_Price - spaceWindow_nextTradePrice*_Point) && (OrderPrice < trading_Price)))
      //  {
      //   return false;
      //  }
      if(OrderPrice == trading_Price)
        {
         return false;
        }

     }
   return true;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Refill_Trades_Crypto_Positions(double trading_Price)
  {
   for(int i=0; i<PositionsTotal(); i++)
     {
      //if(strategy_comment == OrderGetString(POSITION_COMMENT))
      //  {
      // get ticket number
      ulong PositionTicket = PositionGetTicket(i);
      double PositionPrice = PositionGetDouble(POSITION_PRICE_OPEN);
      //Print("Position Price vs tradinPrice: "+PositionPrice+" ticket: "+PositionTicket+"  vs  "+trading_Price);
      if(PositionPrice == trading_Price)
        {
         return false;
        }

     }
   return true;
  }





//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Redeemer_Trade(int number_trades_max)
  {
   if(PositionsTotal() >= number_trades_max)
     {
      return true;
     }
   return false;
//   for(int i=0; i<PositionsTotal(); i++)
//     {
//      //if(strategy_comment == PositionGetString(POSITION_COMMENT))
//      //  {
//      // get ticket number
//      ulong PositionTicket = PositionGetTicket(i);
//
//      trade.PositionClose(PositionTicket);
//      //}
//
//     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int DCA_Trades_Fulfilled(string comment_strat)
  {
   double Open_Positions[11];
// Delete orders if one of the 10 trades get profits.
   if(triggeredTP == 1)
     {
      Delete_All_Orders(comment_strat);
      Delete_All_Positions(comment_strat);
      //DCA_RiskTrade_Breakdown_v2(1.25,(Ask - 800*_Point),Ask + 10*_Point,Ask,1,"strat_0");
     }



   return 0;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Points_Converter(double points)
  {
   return points*(MathPow(10,5))/(MathPow(10,_Digits));
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double step_review(double starting_value)
  {
   double sum = 0;
   double sv = starting_value;
   double array_svs[10];
   for(int i=1; i<=10; i++)
     {
      sum += sv - sv *(1-step(i));
      array_svs[i-1] = sv - sv *(1-step(i));
      sv = sv*(1-step(i));

     }
   sv = starting_value;
   for(int i=1; i<=10; i++)
     {


      //Print("step: "+i+" "+(array_svs[i-1]*100/sum)+" %");
     }
   ArrayPrint(array_svs);
   return sum;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Trade_Price(double curr_Price, int index, int Buy_Sell)
  {
   if(Buy_Sell == 1)
     {
      return curr_Price*(1 -step(index));
     }
   if(Buy_Sell == 0)
     {
      return curr_Price*(1 +step(index));
     }
   return 0;
//return curr_Price*(1 -step(index));
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double price_Deviation = 0.040564/100; // 679 points => 0.04  : This value (0.023564/100) covers 400 points
double Safety_order_step_scale = 1.19;
int Max_safety_trades_count = 10;
int Safety_order_size = 20;
double Safety_order_volume_scale = 1.8;
double Target_profit = 0.15/100;
double Stop_Loss = 1.5/100;
//double TP_line = Ask* (1 + Target_profit);
//double SL_line = Safe_order_line(Max_safety_trades_count) * (1 - Stop_Loss);


//    safety_order_size(i) => Safety_order_size * math.pow(Safety_order_volume_scale, i - 1);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double step(int index)
  {
   if(Symbol() == "AUDUSD")
     {
      price_Deviation = 0.020564/100;
      Safety_order_step_scale = 1.19;
     }
   if(Symbol() == "BTCUSD")
     {
      price_Deviation = 0.090564/100; // It's a 296,081 points window of trades. This is when it's in the 10000s.
      Safety_order_step_scale = 1.19;
     }
//testingSum += pd*MathPow((ss),i);
   double totalSum = 0;
   double pd = price_Deviation;
   double ss = Safety_order_step_scale;
   for(int i = 0; i<index; i++)
     {
      totalSum += pd*MathPow((ss),i);
     }
   return totalSum;
//   switch(index)
//     {
//      case 0:
//         return 0;
//      case 1:
//         return pd;
//      case 2:
//         return pd + pd * ss ;
//      case 3 :
//         return pd + (pd + pd * ss) * ss;
//      case 4 :
//         return pd + (pd + (pd + pd * ss) * ss) * ss;
//      case 5 :
//         return pd + (pd + (pd + (pd + pd * ss) * ss) * ss) * ss ;
//      case 6 :
//         return pd + (pd + (pd + (pd + (pd + pd * ss) * ss) * ss) * ss) * ss ;
//      case 7 :
//         return pd + (pd + (pd + (pd + (pd + (pd + pd * ss) * ss) * ss) * ss) * ss) * ss;
//      case 8 :
//         return pd + (pd + (pd + (pd + (pd + (pd + (pd + pd * ss) * ss) * ss) * ss) * ss) * ss) * ss;
//      case 9 :
//         return pd + (pd + (pd + (pd + (pd + (pd + (pd + (pd + pd * ss) * ss) * ss) * ss) * ss) * ss) * ss) * ss ;
//      case 10 :
//         return pd + (pd + (pd + (pd + (pd + (pd + (pd + (pd + (pd + pd * ss) * ss) * ss) * ss) * ss) * ss) * ss) * ss) * ss;
//
//     }
//   return 0;
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int strategyNum3(double MA_Cross_Continuous_H4,int MA_Cross_M5)
  {

   if(MA_Cross_Continuous_H4 == 1)
     {
      if(MA_Cross_M5 == 1)
        {
         return 1;
        }
      else
         if(MA_Cross_M5 == 0)
           {
            return 1;
           }
         else
           {
            return -1;
           }
     }

   if(MA_Cross_Continuous_H4 == 0)
     {
      if(MA_Cross_M5 == 1)
        {
         return 0;
        }
      else
         if(MA_Cross_M5 == 0)
           {
            return 0;
           }
         else
           {
            return -1;
           }
     }
   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Revive_Trailling_Stopped_Trades(int Buy_Or_Sell, double StopLoss, double Take_Profit, double PriceOpen_Trade)
  {
// Buy: 1 ;  Sell: 0
   if(Buy_Or_Sell == 1)
     {
      // Revive the trade
      trade.BuyLimit(Buying_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE), // Volume
                                   StopLoss
                                   ,PriceOpen_Trade), // Volume
                     PriceOpen_Trade,
                     Symbol(),StopLoss // SL
                     ,Take_Profit      // TP
                     ,0,0,
                     "Revival Buy. StraT_Won...");
     }
   if(Buy_Or_Sell == 0)
     {
      // Revive the trade
      trade.SellStop(Selling_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE), // Volume
                                    StopLoss
                                    ,PriceOpen_Trade), // Volume
                     PriceOpen_Trade,
                     Symbol(),StopLoss // SL
                     ,Take_Profit      // TP
                     ,0,0,
                     "Revival Sell. StraT_Won...");
     }

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool check_Presence_Of_Buy_SellTrades(int Sell_Or_Buy)
  {
   for(int i=PositionsTotal(); i>=0; i--)
     {
      if(Symbol()==PositionGetSymbol(i))
        {

         // get ticket number
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         //Print("Possible trade: "+possible_Trade + " Opened Positins: "+PositionGetDouble(POSITION_PRICE_OPEN) +" "+PositionTicket);

         // IF it's a sell position, then if there already exists other sell trades then
         if(Sell_Or_Buy == 0)
           {
            if(PositionGetInteger(POSITION_TYPE) == 1)
              {
               return true;
              }
           }
         // IF it's a buy position, then if there already exists other buy trades then do ...
         if(Sell_Or_Buy == 1)
           {
            if(PositionGetInteger(POSITION_TYPE) == 0)
              {
               return true;
              }
           }
        }

     }

   return false;
  }

//+------------------------------------------------------------------+
//|This method searches for the ceiling and floor of the current price.
// 1: HigherZone and 0: LowerZone
//+------------------------------------------------------------------+
double Lower_Higher_Support_Resistance(double &PivotBufferPrices_Array[], int Lower_HigherZone_Price, MqlRates &ratesCurr[])
  {
   double Lower_Zone_Price = 0;
   double Higher_Zone_Price = 0;
   ArraySort(PivotBufferPrices_Array);
   for(int i=0; i<ArraySize(PivotBufferPrices_Array); i++)
     {
      //Print("Sprted: ["+i+"] "+PivotBufferPrices_Array[i]);
      if(ratesCurr[1].close > PivotBufferPrices_Array[i])
        {
         Lower_Zone_Price = PivotBufferPrices_Array[i];
        }
      else
        {
         //Lower_HigherZone_Price = PivotBufferPrices_Array[i-1];
         Higher_Zone_Price = PivotBufferPrices_Array[i];
         //Print("Higher vs low: "+ Higher_Zone_Price + " "+Lower_Zone_Price + " rates "+ratesCurr[1].close);
         if(Lower_HigherZone_Price == 1)
           {
            return Higher_Zone_Price;
           }
         else
            if(Lower_HigherZone_Price == 0)
              {
               return Lower_Zone_Price;
              }
        }
     }




   return 0;
  }

bool Buy_Reload_Pass_Version_3 = true;
double Sell_Reload_Pass_Version_3 = true;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int strategyNum2(double MA_Price_LowerPeriod,int MA_Cross_H1,int MA_PriceAction_H1, ENUM_TIMEFRAMES period)
  {
   MqlDateTime STime;
   datetime time_current=TimeCurrent();
   datetime time_local=TimeLocal();

   TimeToStruct(time_current,STime);
//Print("Time Current ",TimeToString(time_current,TIME_DATE|TIME_SECONDS)," day of week ",DayOfWeekDescription(STime.day_of_week));
//Print("Today Hour is: "+STime.hour);

//if(STime.hour == 0)
//  {
//  }

   if(MA_PriceAction_H1 == 1 && STime.min == 0)
     {
      return 1;
     }
   else
      if(MA_PriceAction_H1 == 0 && STime.min == 0)
        {
         return 0;
        }
   return -1;
  }




bool Buy_Pass_H1_Version_3 = true;
double Sell_Pass_H1_Version_3 = true;


int counter_DeletingOrders = 0;
//+------------------------------------------------------------------+
//|This version uses Stop losses.
//+------------------------------------------------------------------+
int Fill_Spaces_With_BuySell_Stops_VERSION_3(double MA_Price_LowerPeriod,int MA_Cross_H1,int MA_PriceAction_H1, ENUM_TIMEFRAMES period)
  {
   MqlDateTime STime;
   datetime time_current=TimeCurrent();
   datetime time_local=TimeLocal();

   TimeToStruct(time_current,STime);
//Print("Time Current ",TimeToString(time_current,TIME_DATE|TIME_SECONDS)," day of week ",DayOfWeekDescription(STime.day_of_week));
//Print("Today Hour is: "+STime.hour);

//if(STime.hour == 0)
//  {
//   Buy_Pass = true;
//   Sell_Pass = true;
//  }

   if(MA_PriceAction_H1 == 1 && Buy_Reload_Pass_Version_3 == true)
     {
      Delete_All_Orders("V.3 Buy. StraT_WinningAllTime "+EnumToString(period));
      Buy_Pass_H1_Version_3 = true;
      Sell_Pass_H1_Version_3 = true;

      Buy_Reload_Pass_Version_3 = false;
      Sell_Reload_Pass_Version_3 = true;
     }
   else
      if(MA_PriceAction_H1 == 0 && Sell_Reload_Pass_Version_3 == true)
        {
         Delete_All_Orders("V.3 Buy. StraT_WinningAllTime "+EnumToString(period));
         Buy_Pass_H1_Version_3 = true;
         Sell_Pass_H1_Version_3 = true;

         Buy_Reload_Pass_Version_3 = true;
         Sell_Reload_Pass_Version_3 = false;
        }

   if(Buy_Pass_H1_Version_3 == true)
     {
      for(int i=0; i<50; i++)
        {
         //if(Prevent_Double_Trades((MA_Price_LowerPeriod +i*20*_Point)) == -1)
         //  {
         //  }
         //else
         //  {
         trade.BuyStop(Buying_Volume(0.0008*AccountInfoDouble(ACCOUNT_BALANCE),
                                     ((MA_Price_LowerPeriod +i*20*_Point) - 1000*_Point) // Volume
                                     ,(MA_Price_LowerPeriod +i*20*_Point)),
                       (MA_Price_LowerPeriod +i*20*_Point),
                       Symbol(),0,((MA_Price_LowerPeriod +i*20*_Point) + 21*_Point),0,0,
                       "V.3 Buy. StraT_WinningAllTime "+EnumToString(period));
         //}



        }
      Buy_Pass_H1_Version_3  = false;
     }


   if(Sell_Pass_H1_Version_3 == true)
     {

      for(int i=0; i<50; i++)
        {
         //if(Prevent_Double_Trades((MA_Price_LowerPeriod -i*20*_Point)) == -1)
         //  {
         //  }
         //else
         //  {
         trade.SellStop(Selling_Volume(0.0008*AccountInfoDouble(ACCOUNT_BALANCE), // Volume
                                       ((MA_Price_LowerPeriod -i*20*_Point) + 1000*_Point)
                                       ,(MA_Price_LowerPeriod -i*20*_Point)),
                        (MA_Price_LowerPeriod -i*20*_Point),
                        Symbol(),0,((MA_Price_LowerPeriod -i*20*_Point) - 21*_Point),0,0,
                        "V.3 Sell. StraT_WinningAllTime "+EnumToString(period));
         //}

        }
      Sell_Pass_H1_Version_3 = false;
     }
   return 1;

  }

//+------------------------------------------------------------------+
//|This method checks if current trades are not duplicated
//+------------------------------------------------------------------+
int Prevent_Double_Trades(double possible_Trade)
  {
   double PositionPrices[10];
   ArrayResize(PositionPrices,PositionsTotal());

   for(int i=PositionsTotal(); i>=0; i--)
     {
      if(Symbol()==PositionGetSymbol(i))
        {
         PositionPrices[i] = PositionGetDouble(POSITION_PRICE_OPEN);
         // get ticket number
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         //Print("Possible trade: "+possible_Trade + " Opened Positins: "+PositionGetDouble(POSITION_PRICE_OPEN) +" "+PositionTicket);

         // if a postion already exists, then return no.
         //if(possible_Trade == PositionGetDouble(POSITION_PRICE_OPEN))
         //  {
         //   Print("True True True True True True True True ");
         //   return -1;
         //  }
        }

     }

   for(int j=ArraySize(PositionPrices) - 1; j>=0; j--)
     {
      for(int i=PositionsTotal(); i>=0; i--)
        {
         if(Symbol()==PositionGetSymbol(j))
           {
            if(PositionPrices[j] == PositionGetDouble(POSITION_PRICE_OPEN))
              {
               trade.PositionClose(PositionGetInteger(POSITION_TICKET));
              }
           }
        }
     }


//      for(int i=OrdersTotal(); i>=0; i--)
//        {
//
//         if(Symbol()==PositionGetSymbol(i))
//           {
//            // get ticket number
//            ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
//            //Print("Possible trade: "+possible_Trade + " Opened Positins: "+PositionGetDouble(POSITION_PRICE_CURRENT) +" "+PositionTicket);
//
//            // if a postion already exists, then return no.
//            if(possible_Trade == OrderGetDouble(ORDER_PRICE_OPEN))
//              {
//               Print("True True True True True True True True ");
//               return -1;
//              }
//           }
//        }


   return 1;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Load_New_Orders()
  {
   for(int i=OrdersTotal(); i>=0; i--)
     {

      // get ticket number
      ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
      //Print("Possible trade: "+possible_Trade + " Opened Positins: "+PositionGetDouble(POSITION_PRICE_CURRENT) +" "+PositionTicket);

      // if there are no orders of this type, then create new ones.
      if(OrderGetInteger(ORDER_TYPE) != 2 && i==0)
        {
         Print("True True True True True True True True ");
         return 1;
        }
      else
         if(OrderGetInteger(ORDER_TYPE) == 3)
           {
           }

     }
   return -1;
  }


bool Buy_Pass_H1_Version_2 = true;
bool Sell_Pass_H1_Version_2 = true;
//+------------------------------------------------------------------+
//|// Place trades on top/bottom of MA prices. Not on each tick but on a some conditions that I know
//+------------------------------------------------------------------+
int Fill_Spaces_With_BuySell_Stops_VERSION_2(double MA_Price_LowerPeriod, ENUM_TIMEFRAMES period)
  {
   int Limit_Number_Trades_Open = 4; // At 1, I can get 5 trades. At 2, I can get 2-3 trades, At 4, I get 1-2 trade only at a time.

   if(Sell_Pass_H1_Version_2 == true)
     {
      double difference_Points_IN_Level_Prices_Sell = 100;
      double number_Of_Trades_Sell = 1*difference_Points_IN_Level_Prices_Sell; // Every 1000 points, I want to make 2x what I can lose
      double distance_betwn_trades_Sell = difference_Points_IN_Level_Prices_Sell/number_Of_Trades_Sell;
      for(int i=0; i<50; i++)
        {
         trade.SellStop(1, ((MA_Price_LowerPeriod - 30*_Point) - i*(17*_Point)),
                        Symbol(),0,((MA_Price_LowerPeriod - 30*_Point) - i*(17*_Point)) - 34*_Point,0,0,
                        "V.2 Sell StraT_WinningAllTimeSell "+EnumToString(period));
        }
      Sell_Pass_H1_Version_2 = false;
     }

// Place trades on top/bottom of MA prices. Not on each tick but on a some conditions that I know
   if(Buy_Pass_H1_Version_2 == true)
     {
      double difference_Points_IN_Level_Prices = 100;
      double number_Of_Trades = 1*difference_Points_IN_Level_Prices; // Every 1000 points, I want to make 2x what I can lose
      double distance_betwn_trades = difference_Points_IN_Level_Prices/number_Of_Trades;
      for(int i=0; i<50; i++)
        {
         trade.BuyStop(1, ((MA_Price_LowerPeriod + 30*_Point) + i*(18*_Point)),
                       Symbol(),0,((MA_Price_LowerPeriod + 30*_Point) + i*(18*_Point)) + 34*_Point,0,0,
                       "V.2 Buy. StraT_WinningAllTime "+EnumToString(period));
        }

      Buy_Pass_H1_Version_2 = false;
     }
//if(CheckNewBar(PERIOD_H1) == 1)
//  {
//Delete_All_Orders();
//}


   return -1;
  }

//+------------------------------------------------------------------+
//|This method clears out all trades within the area Safey Points. It's for preventing any additional hanging trades.
//+------------------------------------------------------------------+
void Hanging_Trades_Prevention_Sys(double &Supp_Resis_Prices_Array[], double areaSafety_Points)
  {
   for(int i=0; i<OrdersTotal(); i++)
     {
      // get ticket number
      ulong OrderTicket = OrderGetTicket(i);
      double orderPrice = OrderGetDouble(ORDER_PRICE_OPEN);
      for(int i=0; i<ArraySize(Supp_Resis_Prices_Array); i++)
        {
         if((orderPrice >= (Supp_Resis_Prices_Array[i] - areaSafety_Points*_Point) && orderPrice <= Supp_Resis_Prices_Array[i])
            ||(orderPrice <= (Supp_Resis_Prices_Array[i] + areaSafety_Points*_Point) && orderPrice >= Supp_Resis_Prices_Array[i]))
           {
            trade.OrderDelete(OrderTicket);
            //i=ArraySize(Supp_Resis_Prices_Array)-1;
           }

        }

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MA_Prices_Return(int indicator_customMA_1, int indicator_customMA_2, ENUM_TIMEFRAMES period, int index)
  {
// This method
// This is made for Higher Timeframes.
   double myMovingAverageArray_lowPer[];
   double myMovingAverageArray_highPer[];
   MqlRates curr_Rates[];
   ArraySetAsSeries(curr_Rates,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),curr_Rates);

   ArraySetAsSeries(myMovingAverageArray_lowPer, true);
   ArraySetAsSeries(myMovingAverageArray_highPer, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer);

   return myMovingAverageArray_lowPer[index];
  }


bool Buy_Pass_H4 = true;
bool Sell_Pass_H4 = true;
bool Buy_Pass_D1 = true;
bool Sell_Pass_D1 = true;
bool Buy_Pass_MN1 = true;
bool Sell_Pass_MN1 = true;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Fill_Spaces_With_BuySell_Stops(int Detected_Pivot_Prices_Zone, double support_S1_Price, double resistance_R1_Price, ENUM_TIMEFRAMES period)
  {
   MqlDateTime STime;
   datetime time_current=TimeCurrent();
   datetime time_local=TimeLocal();
   bool Buy_Pass = false;
   bool Sell_Pass = false;

   if(period == PERIOD_D1)
     {
      Buy_Pass = Buy_Pass_D1;
      Sell_Pass = Sell_Pass_D1;
     }
   else
      if(period == PERIOD_H4)
        {
         Buy_Pass = Buy_Pass_H4;
         Sell_Pass = Sell_Pass_H4;
        }
      else
         if(period == PERIOD_MN1)
           {
            Buy_Pass = Buy_Pass_MN1;
            Sell_Pass = Sell_Pass_MN1;
           }
//else
//  {
//   bool Buy_Pass = false;
//   bool Sell_Pass = false;
//  }

   TimeToStruct(time_current,STime);
//Print("Time Current ",TimeToString(time_current,TIME_DATE|TIME_SECONDS)," day of week ",DayOfWeekDescription(STime.day_of_week));
//Print("Today Hour is: "+STime.hour);

//if(STime.hour == 0)
//  {
//   Buy_Pass = true;
//   Sell_Pass = true;
//  }

   int Limit_Number_Trades_Open = 3; // At 1, I can get 5 trades. At 2, I can get 2-3 trades, At 4, I get 1-2 trade only at a time.

   if(Detected_Pivot_Prices_Zone == 1
      && Buy_Pass == true
     )
     {
      double difference_Points_IN_Level_Prices = MathAbs(support_S1_Price - resistance_R1_Price)*MathPow(10,_Digits);
      double number_Of_Trades = 0.2*difference_Points_IN_Level_Prices; // Every 1000 points, I want to make 2x what I can lose
      double distance_betwn_trades = difference_Points_IN_Level_Prices/number_Of_Trades;
      for(int i=0; i<number_Of_Trades; i++)
        {
         trade.BuyStop(0.3, (support_S1_Price + i*(Limit_Number_Trades_Open *distance_betwn_trades*_Point)),
                       Symbol(),0,(support_S1_Price + i*(Limit_Number_Trades_Open *distance_betwn_trades*_Point)) + 6*_Point,0,0,
                       "StraT_WinningAllTime "+EnumToString(period));
        }
      Buy_Pass = false;
      Sell_Pass = true;
      Print("difference_Points_IN_Level_Prices: "+difference_Points_IN_Level_Prices
            +"\nnumberOfTrades: "+number_Of_Trades
            +"\ndistance_betwn_trades: "+distance_betwn_trades
           );
     }
   else
      if(Detected_Pivot_Prices_Zone == 0
         && Sell_Pass == true
        )
        {
         double difference_Points_IN_Level_Prices_Sell = MathAbs(support_S1_Price - resistance_R1_Price)*MathPow(10,_Digits);
         double number_Of_Trades_Sell = 0.2*difference_Points_IN_Level_Prices_Sell; // Every 1000 points, I want to make 2x what I can lose
         double distance_betwn_trades_Sell = difference_Points_IN_Level_Prices_Sell/number_Of_Trades_Sell;
         for(int i=0; i<number_Of_Trades_Sell; i++)
           {
            trade.SellStop(0.3, (resistance_R1_Price - i*(Limit_Number_Trades_Open *distance_betwn_trades_Sell*_Point)),
                           Symbol(),0,(resistance_R1_Price - i*(Limit_Number_Trades_Open*distance_betwn_trades_Sell*_Point)) - 6*_Point,0,0,
                           "StraT_WinningAllTimeSell "+EnumToString(period));
           }
         Sell_Pass = false;
         Buy_Pass = true;
         Print("difference_Points_IN_Level_Prices Sell: "+difference_Points_IN_Level_Prices_Sell
               +"\nnumberOfTrades Sell: "+number_Of_Trades_Sell
               +"\ndistance_betwn_trades Sell: "+distance_betwn_trades_Sell
              );
        }

   if(period == PERIOD_D1)
     {
      Buy_Pass_D1 = Buy_Pass;
      Sell_Pass_D1 = Sell_Pass;
     }
   else
      if(period == PERIOD_H4)
        {
         Buy_Pass_H4 = Buy_Pass;
         Sell_Pass_H4 = Sell_Pass;
        }
      else
         if(period == PERIOD_MN1)
           {
            Buy_Pass_MN1 = Buy_Pass;
            Sell_Pass_MN1 = Sell_Pass;
           }

   return -1;
  }



//+------------------------------------------------------------------+
//|This method's purpose is to protect us from hanging trades. If there is two open trades
//|then two opposite order trades are created.
//+------------------------------------------------------------------+
int Insured_Filled_Spaces_With_BuySell_Stops(int Detected_Pivot_Prices_Zone, double support_S1_Price, double resistance_R1_Price, ENUM_TIMEFRAMES period)
  {
   MqlDateTime STime;
   datetime time_current=TimeCurrent();
   datetime time_local=TimeLocal();
   bool Buy_Pass = false;
   bool Sell_Pass = false;

   if(period == PERIOD_D1)
     {
      Buy_Pass = Buy_Pass_D1;
      Sell_Pass = Sell_Pass_D1;
     }
   else
      if(period == PERIOD_H4)
        {
         Buy_Pass = Buy_Pass_H4;
         Sell_Pass = Sell_Pass_H4;
        }
      else
         if(period == PERIOD_MN1)
           {
            Buy_Pass = Buy_Pass_MN1;
            Sell_Pass = Sell_Pass_MN1;
           }

   int Limit_Number_Trades_Open = 1; // At 1, I can get 5 trades. At 2, I can get 2-3 trades, At 4, I get 1-2 trade only at a time.

   for(int i=PositionsTotal(); i>=0; i--)
     {
      if(Symbol()==PositionGetSymbol(i))
        {
         // get ticket number
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
         if(PositionGetInteger(POSITION_TYPE) == 0)
           {
            double difference_Points_IN_Level_Prices_Sell = MathAbs(support_S1_Price - resistance_R1_Price)*MathPow(10,_Digits);
            double number_Of_Trades_Sell = 0.2*difference_Points_IN_Level_Prices_Sell; // Every 1000 points, I want to make 2x what I can lose
            double distance_betwn_trades_Sell = difference_Points_IN_Level_Prices_Sell/number_Of_Trades_Sell;

            // Sell trades
            for(int i=0; i<number_Of_Trades_Sell; i++)
              {
               trade.SellStop(0.3, (PositionGetDouble(POSITION_PRICE_OPEN) - i*(Limit_Number_Trades_Open *distance_betwn_trades_Sell*_Point)),
                              Symbol(),0,(PositionGetDouble(POSITION_PRICE_OPEN) - i*(Limit_Number_Trades_Open*distance_betwn_trades_Sell*_Point)) - 6*_Point,0,0,
                              "Winnig_Safety_Sell"+EnumToString(period));
              }

           }


         if(PositionGetInteger(POSITION_TYPE) == 1)
           {
            double difference_Points_IN_Level_Prices = MathAbs(support_S1_Price - resistance_R1_Price)*MathPow(10,_Digits);
            double number_Of_Trades = 0.2*difference_Points_IN_Level_Prices; // Every 1000 points, I want to make 2x what I can lose
            double distance_betwn_trades = difference_Points_IN_Level_Prices/number_Of_Trades;
            // Buy Trades
            for(int i=0; i<number_Of_Trades; i++)
              {
               trade.BuyStop(0.3, (PositionGetDouble(POSITION_PRICE_OPEN) + i*(Limit_Number_Trades_Open *distance_betwn_trades*_Point)),
                             Symbol(),0,(PositionGetDouble(POSITION_PRICE_OPEN) + i*(Limit_Number_Trades_Open *distance_betwn_trades*_Point)) + 6*_Point,0,0,
                             "Winnig_Safety_Buy"+EnumToString(period));
              }

           }

        }
     }
   if(period == PERIOD_D1)
     {
      Buy_Pass_D1 = Buy_Pass;
      Sell_Pass_D1 = Sell_Pass;
     }
   else
      if(period == PERIOD_H4)
        {
         Buy_Pass_H4 = Buy_Pass;
         Sell_Pass_H4 = Sell_Pass;
        }
      else
         if(period == PERIOD_MN1)
           {
            Buy_Pass_MN1 = Buy_Pass;
            Sell_Pass_MN1 = Sell_Pass;
           }

   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Detect_Pivot_Prices_Zone(double indicator_handlePivot_S1, double indicator_handlePivot_R1, ENUM_TIMEFRAMES period, MqlRates &ratesCurr[])
  {
   if(check_Price_IN_OUT_PivotZone(indicator_handlePivot_S1,period,ratesCurr) == 1)
     {
      return 1;
     }
   else
      if(check_Price_IN_OUT_PivotZone(indicator_handlePivot_R1,period,ratesCurr) == 1)
        {
         return 0;
        }
   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int check_Price_IN_OUT_PivotZone(double targetPrice, ENUM_TIMEFRAMES period, MqlRates &ratesCurr[])
  {
   if((ratesCurr[1].low <= targetPrice && ratesCurr[1].high >= targetPrice) ||
      (ratesCurr[1].low >= targetPrice && ratesCurr[1].high <= targetPrice))
     {
      return 1;
     }
   return -1;
  }


bool allow_Buy = true;
bool allow_Sell = true;
int strat_1010101_Input = -1;
//+------------------------------------------------------------------+
//|This strategy checks if price is within a (selected period) monthly pivot zone, in order to change Direction...
//+------------------------------------------------------------------+
int strategyNum_1010101010(double Higher_Side_Pivot_Monthly, double Lower_Side_Pivot_Monthly,double SelectedPeriod_Pivot, double SelectedPeriod_R1,
                           double SelectedPeriod_R2, double SelectedPeriod_R3, double SelectedPeriod_S1, double SelectedPeriod_S2, double SelectedPeriod_S3,
                           int MA_PriceAction_H1, MqlRates &ratesCurr[])
  {
//if(Higher_Side_Pivot_Monthly == SelectedPeriod_R1 || Higher_Side_Pivot_Monthly == SelectedPeriod_R2 || Higher_Side_Pivot_Monthly == SelectedPeriod_R3)
//  {
   if((ratesCurr[1].high >= SelectedPeriod_R1  && ratesCurr[1].low <= SelectedPeriod_R1) || (ratesCurr[1].high >= SelectedPeriod_R2  && ratesCurr[1].low <= SelectedPeriod_R2)
      || (ratesCurr[1].high >= SelectedPeriod_R3  && ratesCurr[1].low <= SelectedPeriod_R3))
     {
      return 0;
     }
//}


   if(Lower_Side_Pivot_Monthly == SelectedPeriod_Pivot || Higher_Side_Pivot_Monthly == SelectedPeriod_Pivot)
     {
      if(ratesCurr[1].low >= (Higher_Side_Pivot_Monthly - 90*_Point))
        {
         strat_1010101_Input = 0;
         return strat_1010101_Input;
        }
      if(ratesCurr[1].low <= (Lower_Side_Pivot_Monthly + 90*_Point))
        {
         strat_1010101_Input = 1;
         return strat_1010101_Input;
        }
     }

   if((ratesCurr[1].high >= SelectedPeriod_S1  && ratesCurr[1].low <= SelectedPeriod_S1) || (ratesCurr[1].high >= SelectedPeriod_S2  && ratesCurr[1].low <= SelectedPeriod_S2)
      || (ratesCurr[1].high >= SelectedPeriod_S3  && ratesCurr[1].low <= SelectedPeriod_S3))
     {
      return 1;
     }


   return strat_1010101_Input;
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int strategyNum_000000(int MA_Cross_Continuous_H4,int MA_PriceAction_H1,MqlRates &ratesCurr[])
  {
//if(MA_Cross_Continuous_H4 == 1)
//  {
//   return 1;
//  }
//if(MA_Cross_Continuous_H4 == 0)
//  {
//   return 0;
//  }

   if(MA_PriceAction_H1 == 1)
     {
      return 1;
     }
   if(MA_PriceAction_H1 == 0)
     {
      return 0;
     }
   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int strategyNum1(int trendLine_PriceAction_M5, int MarketDir, int fib_status_H1)
  {
   if(MarketDir == 1)
     {
      if(fib_status_H1 == 1)
        {
         if(trendLine_PriceAction_M5 == 1)
           {
            return 1;
           }
        }
     }
   else
      if(MarketDir == 0)
        {
         if(fib_status_H1 == 1)
           {
            if(trendLine_PriceAction_M5 == 0)
              {
               return 0;
              }
           }
        }
   return -1;
  }

bool pass_ticket_buy = false;
bool pass_ticket_sell = false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int DelayEntry_TrendLine_PriceAction(int trendLine_PriceAction_M5, int MA_PriceAction_M5, int MArketDir)
  {
   Print("pASS TICKET :     "+pass_ticket_buy +" vs sell tick/:  "+pass_ticket_sell);
   if(MArketDir == 1 && (trendLine_PriceAction_M5 == 1 || pass_ticket_buy == true))
     {
      if(MA_PriceAction_M5 == 1)
        {
         pass_ticket_buy = false;
         return 1;
        }
      else
        {
         pass_ticket_buy = true;
         return -1;
        }
     }
   if(MArketDir == 0 &&(trendLine_PriceAction_M5 == 0 || pass_ticket_sell == true))
     {
      if(MA_PriceAction_M5 == 0)
        {
         pass_ticket_sell = false;
         return 0;
        }
      else
        {
         pass_ticket_sell = true;
         return -1;
        }
     }
   return -1;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Market_Direction(int adx_h1, int DI_h1,int MA_PriceActionStat_h1, int trendlineStatus_h1)
  {
   if(MA_PriceActionStat_h1 == 1 || trendlineStatus_h1 == 1)
     {
      if(adx_h1 == 1)
        {
         if(DI_h1 == 1)
           {
            return 1;
           }

        }
      else
        {
         if(DI_h1 == 1 && trendlineStatus_h1 == 1)
           {
            return 1;
           }
        }

     }
   if(MA_PriceActionStat_h1 == 0 || trendlineStatus_h1 == 0)
     {
      if(adx_h1 == 1)
        {
         if(DI_h1 == 0)
           {
            return 0;
           }

        }
      else
        {
         if(DI_h1 == 0 && trendlineStatus_h1 == 0)
           {
            return 0;
           }
        }

     }

   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Market_Structure(int indicator_customADX, ENUM_TIMEFRAMES period)
  {
//--- indicator buffers
   double    ExtADXBuffer[30];
   double    ExtPDIBuffer[30];
   double    ExtNDIBuffer[30];
   double    ExtPDBuffer[30];
   double    ExtNDBuffer[30];
   double    ExtTmpBuffer[30];

   ArraySetAsSeries(ExtADXBuffer, true);
   ArraySetAsSeries(ExtNDBuffer, true);
   ArraySetAsSeries(ExtPDBuffer, true);
   ArraySetAsSeries(ExtNDIBuffer, true);
   ArraySetAsSeries(ExtPDIBuffer, true);
   ArraySetAsSeries(ExtTmpBuffer, true);

   CopyBuffer(indicator_customADX,0,0,30,ExtADXBuffer);
   CopyBuffer(indicator_customADX,1,0,30,ExtPDIBuffer);
   CopyBuffer(indicator_customADX,2,0,30,ExtNDIBuffer);
   Print("ExtPDIBuffer vs ExtNDI: "+ExtPDIBuffer[29]+" VS "+ExtNDIBuffer[29]+" vs adx: "+ExtADXBuffer[29]);
//Market_Structure_2(indicator_customADX);
//Comment("ExtADXBuffer[0]: "+ExtADXBuffer[0]);
   Print("adx: "+ExtADXBuffer[29]+EnumToString(period));

   if(ExtADXBuffer[29] > 20)
     {
      return 1;
     }
   else
      if((ExtADXBuffer[29] > 20 && ExtPDIBuffer[1] > 20 && ExtNDIBuffer[1] > 20)
         && (ExtADXBuffer[29] < 25 && ExtPDIBuffer[1] < 25 && ExtNDIBuffer[1] < 25))
        {
         return -1;
        }
      else
        {
         return -1;
        }

//if((ExtADXBuffer[29] > 20 && ExtPDIBuffer[1] > 20 && ExtNDIBuffer[1] > 20)
//   && (ExtADXBuffer[29] < 25 && ExtPDIBuffer[1] < 25 && ExtNDIBuffer[1] < 25))
//  {
//   return -1;
//  }
//else
//   if(ExtPDIBuffer[29] > 20 && ExtADXBuffer[29] > 21)
//     {
//      return 1;
//     }
//   else
//      if(ExtADXBuffer[29] > 21 && ExtNDIBuffer[29] > 20)
//        {
//         return 1;
//        }
//      else
//        {
//         return -1;
//        }

  }


//+------------------------------------------------------------------+
//| This method checks if DI+ and DI- have crossed or not            |
//+------------------------------------------------------------------+
int Market_Structure_2(int indicator_customADX, ENUM_TIMEFRAMES period)
  {
//--- indicator buffers
   double    ExtADXBuffer[30];
   double    ExtPDIBuffer[30];
   double    ExtNDIBuffer[30];
   double    ExtPDBuffer[30];
   double    ExtNDBuffer[30];
   double    ExtTmpBuffer[30];

   ArraySetAsSeries(ExtADXBuffer, true);
   ArraySetAsSeries(ExtNDBuffer, true);
   ArraySetAsSeries(ExtPDBuffer, true);
   ArraySetAsSeries(ExtNDIBuffer, true);
   ArraySetAsSeries(ExtPDIBuffer, true);
   ArraySetAsSeries(ExtTmpBuffer, true);

   CopyBuffer(indicator_customADX,0,0,30,ExtADXBuffer);
   CopyBuffer(indicator_customADX,1,0,30,ExtPDIBuffer);
   CopyBuffer(indicator_customADX,2,0,30,ExtNDIBuffer);

//Comment("ExtADXBuffer[0]: "+ExtADXBuffer[0]);
//if(ExtPDIBuffer[29] > 20 || ExtNDIBuffer[29] > 20)
//  {
   if(ExtPDIBuffer[29] > ExtNDIBuffer[29])
     {
      Print("CROSSED UP: "+EnumToString(period)+" "+ExtNDIBuffer[29]+" DI+: "+ExtPDIBuffer[29]+" adx: "+ExtADXBuffer[29]);
      return 1;
     }
   else
      if(ExtPDIBuffer[29] < ExtNDIBuffer[29])
        {
         Print("CROSSED DOWN: "+EnumToString(period)+" "+ExtNDIBuffer[29]+" DI+: "+ExtPDIBuffer[29]);
         return 0;
        }
      else
        {
         Print("NOT YET: "+ExtNDIBuffer[1]+" DI+: "+ExtPDIBuffer[1]);
         return -1;
        }

//}
//else
//  {
//   return -1;
//  }


  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int MA_Cross(int indicator_customMA_1, int indicator_customMA_2)
  {
   double myMovingAverageArray_lowPer_Cr[];
   double myMovingAverageArray_highPer_Cr[];



   ArraySetAsSeries(myMovingAverageArray_lowPer_Cr, true);
   ArraySetAsSeries(myMovingAverageArray_highPer_Cr, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer_Cr);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer_Cr);
//Comment(myMovingAverageArray_lowPer_Cr[1] +" "+myMovingAverageArray_highPer_Cr[1]);
// Crossover bwteen 8-P and 14-P.
   if(myMovingAverageArray_lowPer_Cr[1] > myMovingAverageArray_highPer_Cr[1]
      && myMovingAverageArray_lowPer_Cr[2]<myMovingAverageArray_highPer_Cr[2]
     )
     {
      //crossedStatus = 1;
      //Print("Crossed Up Up");


      return 1;

     }
   else
      //   Crossover bwteen 8-P and 14-P.
      if(myMovingAverageArray_lowPer_Cr[1]<myMovingAverageArray_highPer_Cr[1]
         && myMovingAverageArray_lowPer_Cr[2]>myMovingAverageArray_highPer_Cr[2]
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int MA_Cross_Continuous(int indicator_customMA_1, int indicator_customMA_2)
  {
   double myMovingAverageArray_lowPer_Cr[];
   double myMovingAverageArray_highPer_Cr[];



   ArraySetAsSeries(myMovingAverageArray_lowPer_Cr, true);
   ArraySetAsSeries(myMovingAverageArray_highPer_Cr, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer_Cr);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer_Cr);
//Comment(myMovingAverageArray_lowPer_Cr[1] +" "+myMovingAverageArray_highPer_Cr[1]);
// Crossover bwteen 8-P and 14-P.
   if(myMovingAverageArray_lowPer_Cr[1]>myMovingAverageArray_highPer_Cr[1]
     )
     {
      //crossedStatus = 1;
      //Print("Crossed Up Up");


      return 1;

     }
   else
      //   Crossover bwteen 8-P and 14-P.
      if(myMovingAverageArray_lowPer_Cr[1]<myMovingAverageArray_highPer_Cr[1]
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int MA_PriceAction(int indicator_customMA_1, int indicator_customMA_2, ENUM_TIMEFRAMES period)
  {
// This method
// This is made for Higher Timeframes.
   double myMovingAverageArray_lowPer[];
   double myMovingAverageArray_highPer[];
   MqlRates curr_Rates[];
   ArraySetAsSeries(curr_Rates,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),curr_Rates);

   ArraySetAsSeries(myMovingAverageArray_lowPer, true);
   ArraySetAsSeries(myMovingAverageArray_highPer, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer);

//Print("Curr rates: "+curr_Rates[1].close);
//&& (curr_Rates[2].close > myMovingAverageArray_lowPer[2])
   if((curr_Rates[1].close < myMovingAverageArray_lowPer[1]))
     {
      return 0;
     }
   else
      if((curr_Rates[1].close > myMovingAverageArray_lowPer[1]))
        {
         //&& (curr_Rates[2].close < myMovingAverageArray_lowPer[2])
         return 1;
        }
      else
        {
         return -1;
        }

  }


//+------------------------------------------------------------------+
//|This method checks the direction of the trend (facing upward/downard)
//+------------------------------------------------------------------+
int TrendLine_Status(int indicator_handleTrending_Angle_R, ENUM_TIMEFRAMES period, MqlRates &ratesCurr[])
  {
// Used by s_rind. Trendline
   double support_DataTrendLine[20], resistance_DataTrendLine[20];
   ArraySetAsSeries(support_DataTrendLine,true);
   ArraySetAsSeries(resistance_DataTrendLine, true);

   CopyBuffer(indicator_handleTrending_Angle_R,0,0,20,support_DataTrendLine);
   CopyBuffer(indicator_handleTrending_Angle_R,1,0,20,resistance_DataTrendLine);

   if(((resistance_DataTrendLine[10]-resistance_DataTrendLine[1]) < 0) && ((support_DataTrendLine[10]-support_DataTrendLine[1]) > 0))
     {
      return -1;
     }
   else
      if((resistance_DataTrendLine[10]-resistance_DataTrendLine[1]) < 0)
        {
         return 0;
        }
      else
         if((support_DataTrendLine[10]-support_DataTrendLine[1]) > 0)
           {
            return 1;
           }

   return -1;
  }


//+------------------------------------------------------------------+
//|This method is like the Fibonacci lines. It measures the retracement of a trend.
//+------------------------------------------------------------------+
int TrendLine_PriceAction(int indicator_handleTrending_Angle_R, ENUM_TIMEFRAMES period)
  {
   MqlRates ratesCurr[];
   ArraySetAsSeries(ratesCurr,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),ratesCurr);

// Used by s_rind. Trendline
   double support_DataTrendLine[20], resistance_DataTrendLine[20];
   ArraySetAsSeries(support_DataTrendLine,true);
   ArraySetAsSeries(resistance_DataTrendLine, true);

   CopyBuffer(indicator_handleTrending_Angle_R,0,0,20,support_DataTrendLine);
   CopyBuffer(indicator_handleTrending_Angle_R,1,0,20,resistance_DataTrendLine);
   Print("supp[18]: "+support_DataTrendLine[18] + " vs res[18]: "+resistance_DataTrendLine[18]);

   if((support_DataTrendLine[10]-support_DataTrendLine[1]) > 0) // Needs to be pointing upwards
     {
      if((ratesCurr[1].low <= support_DataTrendLine[18] && ratesCurr[1].close >= support_DataTrendLine[18])
         || (ratesCurr[1].open <= support_DataTrendLine[18] && ratesCurr[1].close > support_DataTrendLine[18]))
        {
         return 1;
        }
     }
   else
      if((resistance_DataTrendLine[10]-resistance_DataTrendLine[1]) < 0)
        {
         if((ratesCurr[1].high >= resistance_DataTrendLine[18] && ratesCurr[1].close <= resistance_DataTrendLine[18])
            || (ratesCurr[1].open >= resistance_DataTrendLine[18] && ratesCurr[1].close < resistance_DataTrendLine[18]))
           {
            return 0;
           }
        }
      else
        {
         return -1;
        }


   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int BreakStructureTrendline(int indicator_handleTrending_Angle_R, ENUM_TIMEFRAMES period) // Break Of Structure Confluence:
  {

   MqlRates ratesCurr[];
   ArraySetAsSeries(ratesCurr,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),ratesCurr);

// Used by s_rind. Trendline
   double support_DataTrendLine[20], resistance_DataTrendLine[20];
   ArraySetAsSeries(support_DataTrendLine,true);
   ArraySetAsSeries(resistance_DataTrendLine, true);

   CopyBuffer(indicator_handleTrending_Angle_R,0,0,20,support_DataTrendLine);
   CopyBuffer(indicator_handleTrending_Angle_R,1,0,20,resistance_DataTrendLine);

// break of Support
   if(support_DataTrendLine[19] > ratesCurr[1].close)
     {
      //BreakStrStatus = 0;
      //Print("@@@@@@@@@@ Broken Down Down @@@@@@@@@@");
      //Print("Broken Structure Down");
      return 0;
     }
   else
      if(resistance_DataTrendLine[19] < ratesCurr[1].close)
        {
         //BreakStrStatus = 1;
         //Print("@@@@@@@@@@ Broken Up Up @@@@@@@@@@");
         return 1;
        }
      else
        {
         //BreakStrStatus = -1;
         return -1;
        }


  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int BreakStructurePriceAction_ADX(int indicator_customADX, ENUM_TIMEFRAMES period)
  {
//--- indicator buffers
   double    ExtADXBuffer[30];
   double    ExtPDIBuffer[30];
   double    ExtNDIBuffer[30];
   double    ExtPDBuffer[30];
   double    ExtNDBuffer[30];
   double    ExtTmpBuffer[30];

   ArraySetAsSeries(ExtADXBuffer, true);

   ArraySetAsSeries(ExtNDIBuffer, true);
   ArraySetAsSeries(ExtPDIBuffer, true);
   ArraySetAsSeries(ExtTmpBuffer, true);

   CopyBuffer(indicator_customADX,0,0,30,ExtADXBuffer);
   CopyBuffer(indicator_customADX,1,0,30,ExtPDIBuffer);
   CopyBuffer(indicator_customADX,2,0,30,ExtNDIBuffer);

//Comment("ExtADXBuffer[0]: "+ExtADXBuffer[0]);
//if(ExtPDIBuffer[29] > 20 || ExtNDIBuffer[29] > 20)
//  {
   if((ExtPDIBuffer[29] > ExtNDIBuffer[29])
      && (ExtPDIBuffer[28] < ExtNDIBuffer[28])
     )
     {
      return 1;
     }
   else
      if(ExtPDIBuffer[29] < ExtNDIBuffer[29]
         && (ExtPDIBuffer[28] > ExtNDIBuffer[28])
        )
        {
         return 0;
        }
      else
        {
         return -1;
        }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void placeOrders_Pivot_SupportResistance(int indicator_handlePivot_R, ENUM_TIMEFRAMES period)
  {
//--- indicator buffers: Pivot.mq5 indicator
   double         PivotBuffer[];
   double         R1Buffer[];
   double         R2Buffer[];
   double         R3Buffer[];
   double         S1Buffer[];
   double         S2Buffer[];
   double         S3Buffer[];

   int R1_S1_Area_Check;
   int R2_S2_Area_Check;
   int R3_S3_Area_Check;
   int Pivot_Area_Check;


   ArraySetAsSeries(PivotBuffer, true);
   ArraySetAsSeries(R1Buffer,true);
   ArraySetAsSeries(R2Buffer,true);
   ArraySetAsSeries(R3Buffer,true);
   ArraySetAsSeries(S1Buffer,true);
   ArraySetAsSeries(S2Buffer,true);
   ArraySetAsSeries(S3Buffer,true);

   CopyBuffer(indicator_handlePivot_R,0,0,50,PivotBuffer);
   CopyBuffer(indicator_handlePivot_R,1,0,50,R1Buffer);
   CopyBuffer(indicator_handlePivot_R,2,0,50,R2Buffer);
   CopyBuffer(indicator_handlePivot_R,3,0,50,R3Buffer);
   CopyBuffer(indicator_handlePivot_R,4,0,50,S1Buffer);
   CopyBuffer(indicator_handlePivot_R,5,0,50,S2Buffer);
   CopyBuffer(indicator_handlePivot_R,6,0,50,S3Buffer);

   for(int i=1; i< 3; i++)
     {
      trade.BuyLimit(1,S1Buffer[i],
                     Symbol(),0,S1Buffer[i] + 10*_Point,0,0,"StraT_Pivots000");
      trade.BuyLimit(1,S2Buffer[i],
                     Symbol(),0,S2Buffer[i] + 10*_Point,0,0,"StraT_Pivots000");
      trade.BuyLimit(1,S3Buffer[i],
                     Symbol(),0,S3Buffer[i] + 10*_Point,0,0,"StraT_Pivots000");

      trade.SellLimit(1,R1Buffer[i],
                      Symbol(),0,R1Buffer[i] - 10*_Point,0,0,"StraT_Pivots000");
      trade.SellLimit(1,R2Buffer[i],
                      Symbol(),0,R2Buffer[i] - 10*_Point,0,0,"StraT_Pivots000");
      trade.SellLimit(1,R3Buffer[i],
                      Symbol(),0,R3Buffer[i] - 10*_Point,0,0,"StraT_Pivots000");
     }

  }
  
  

//+------------------------------------------------------------------+
//| // This indicator returns the values of Pivot Points Prices.
//+------------------------------------------------------------------+
double PivotBufferPrices(int indicator_handlePivot_R, ENUM_TIMEFRAMES period, int code_Buffer)
  {
// This indicator returns the values of Pivot Points Prices.
//--- indicator buffers:
//  Pivot.mq5 indicator
   double         PivotBuffer[];
   double         R1Buffer[];
   double         R2Buffer[];
   double         R3Buffer[];
   double         S1Buffer[];
   double         S2Buffer[];
   double         S3Buffer[];

   ArraySetAsSeries(PivotBuffer, true);
   ArraySetAsSeries(R1Buffer,true);
   ArraySetAsSeries(R2Buffer,true);
   ArraySetAsSeries(R3Buffer,true);
   ArraySetAsSeries(S1Buffer,true);
   ArraySetAsSeries(S2Buffer,true);
   ArraySetAsSeries(S3Buffer,true);

   CopyBuffer(indicator_handlePivot_R,0,0,50,PivotBuffer);
   CopyBuffer(indicator_handlePivot_R,1,0,50,R2Buffer);
   CopyBuffer(indicator_handlePivot_R,2,0,50,R3Buffer);
   CopyBuffer(indicator_handlePivot_R,3,0,50,R1Buffer);
   CopyBuffer(indicator_handlePivot_R,4,0,50,S1Buffer);
   CopyBuffer(indicator_handlePivot_R,5,0,50,S2Buffer);
   CopyBuffer(indicator_handlePivot_R,6,0,50,S3Buffer);

   if(code_Buffer == 0)
     {
      return PivotBuffer[1];
     }
   else
      if(code_Buffer == 1)
        {
         return R1Buffer[1];
        }
      else
         if(code_Buffer == 2)
           {
            return R2Buffer[1];
           }
         else
            if(code_Buffer == 3)
              {
               return R3Buffer[1];
              }
            else
               if(code_Buffer == 4)
                 {
                  return S1Buffer[1];
                 }
               else
                  if(code_Buffer == 5)
                    {
                     return S2Buffer[1];
                    }
                  else
                     if(code_Buffer == 6)
                       {
                        return S3Buffer[1];
                       }
                     else
                       {
                        return 0;
                       }



  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TraillingStopLoss(double NewStopLoss)
  {
// desired stop loss

   for(int i=PositionsTotal(); i>=0; i--)
     {
      if(Symbol()==PositionGetSymbol(i))
        {
         // get ticket number
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);


         // Modify Stpo loss
         trade.PositionModify(PositionTicket,NewStopLoss,PositionGetDouble(POSITION_TP));

        }
     }
  }

//+------------------------------------------------------------------+
int changeSLSelling(double usualStopLoss, double newStopLoss, double Position_OPEN_Price, string Position_Comment)
  {
   if(Position_Comment == "Revival Sell. StraT_Won...")
     {
      // No change of SL
      return -1;
     }
   else
      if(usualStopLoss !=0 && usualStopLoss >= newStopLoss && newStopLoss != Position_OPEN_Price)
        {
         TraillingStopLoss(newStopLoss);
         return 0;
        }
   return -1;

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int changeSLBuying(double usualStopLoss, double newStopLoss, double Position_OPEN_Price, string Position_Comment)
  {
   Print("Usual SL: "+usualStopLoss + " newStopLoss: "+newStopLoss+" open price: "+Position_OPEN_Price);
   if(Position_Comment == "Revival Buy. StraT_Won...")
     {
      // No change of SL.
      return -1;
     }
   else
      if(usualStopLoss !=0 && usualStopLoss < newStopLoss && newStopLoss != Position_OPEN_Price)
        {
         TraillingStopLoss(newStopLoss);
         return 1;
        }
//TraillingStopLoss(newStopLoss);
   return -1;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Support_and_Resistance_Prices(int indicator_handleSupRes_R, int index, int BuyOrSell)
  {
   double SupportBuffer[];
   double ResiBuffer[];
   ArraySetAsSeries(SupportBuffer,true);
   ArraySetAsSeries(ResiBuffer, true);

   CopyBuffer(indicator_handleSupRes_R,0,0,100,SupportBuffer);
   CopyBuffer(indicator_handleSupRes_R,1,0,100,ResiBuffer);

   if(BuyOrSell == 1)
     {
      return SupportBuffer[index];
     }
   else
      if(BuyOrSell == 0)
        {
         return ResiBuffer[index];
        }
   return -1;

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Pivot_Support_Resistance_Area_Check(int indicator_handlePivot_R, ENUM_TIMEFRAMES period, double radiusCheck)
  {
//--- indicator buffers: Pivot.mq5 indicator
   double         PivotBuffer[];
   double         R1Buffer[];
   double         R2Buffer[];
   double         R3Buffer[];
   double         S1Buffer[];
   double         S2Buffer[];
   double         S3Buffer[];

   int R1_S1_Area_Check;
   int R2_S2_Area_Check;
   int R3_S3_Area_Check;
   int Pivot_Area_Check;


   ArraySetAsSeries(PivotBuffer, true);
   ArraySetAsSeries(R1Buffer,true);
   ArraySetAsSeries(R2Buffer,true);
   ArraySetAsSeries(R3Buffer,true);
   ArraySetAsSeries(S1Buffer,true);
   ArraySetAsSeries(S2Buffer,true);
   ArraySetAsSeries(S3Buffer,true);

   CopyBuffer(indicator_handlePivot_R,0,0,50,PivotBuffer);
   CopyBuffer(indicator_handlePivot_R,1,0,50,R1Buffer);
   CopyBuffer(indicator_handlePivot_R,2,0,50,R2Buffer);
   CopyBuffer(indicator_handlePivot_R,3,0,50,R3Buffer);
   CopyBuffer(indicator_handlePivot_R,4,0,50,S1Buffer);
   CopyBuffer(indicator_handlePivot_R,5,0,50,S2Buffer);
   CopyBuffer(indicator_handlePivot_R,6,0,50,S3Buffer);
//PivotBufferPrices[0]=PivotBuffer[1];
//PivotBufferPrices[1]=R1Buffer[1];
//PivotBufferPrices[2]=R2Buffer[1];
//PivotBufferPrices[3]=R3Buffer[1];
//PivotBufferPrices[4]=S1Buffer[1];
//PivotBufferPrices[5]=S2Buffer[1];
//PivotBufferPrices[6]=S3Buffer[1];

//Comment("Pivot Buffer[0]: "+PivotBuffer[0] +" VS "+R1Buffer[0] + " VS "+S1Buffer[0] + " VS "+S2Buffer[0]);
//Comment("S2Buff: "+S2Buffer[1]+" S1Buff: " + S1Buffer[1]);
//Comment("500*point "+(S2Buffer[1]+500*_Point)+" vs "+S2Buffer[1]);
//Print("S2Buff: "+S2Buffer[0]+" S1Buff: " + S1Buffer[0]);
   if(Support_Resistance_Area_BluePrint(R1Buffer,S1Buffer,period,radiusCheck) >= 0)
     {
      return 1;
     }
   else
      if(Support_Resistance_Area_BluePrint(R2Buffer,S2Buffer,period,radiusCheck) >= 0)
        {
         return 1;
        }
      else
         if(Support_Resistance_Area_BluePrint(R3Buffer,S3Buffer,period,radiusCheck) >= 0)
           {
            return 1;
           }
         else
            if(Support_Resistance_Area_BluePrint(PivotBuffer,S3Buffer,period,radiusCheck) >= 0)
              {
               return 1;
              }
            else
              {
               return -1;
              }



  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Support_Resistance_Area_BluePrint(double &BuyBuffer[], double &SellBuffer[], ENUM_TIMEFRAMES basePeriod, int intervalZone)
  {
   MqlRates curr_Rates[];
   ArraySetAsSeries(curr_Rates,true);
   CopyRates(Symbol(),basePeriod,0,Bars(Symbol(),basePeriod),curr_Rates);
   if(curr_Rates[1].close <= BuyBuffer[1] && curr_Rates[1].close >= (BuyBuffer[1]-intervalZone*_Point))
     {
      //Print("Resistance Lower");

      // Resistance Zone: Lower Side

      // Check if the support is in the interval also
      if(curr_Rates[1].close >= SellBuffer[1] && curr_Rates[1].close <= (SellBuffer[1] + intervalZone*_Point) ||
         curr_Rates[1].close <= SellBuffer[1] && curr_Rates[1].close >= (SellBuffer[1] - intervalZone*_Point))
        {
         //Print("Support also");
         if(MathAbs(curr_Rates[1].close - SellBuffer[1]) > MathAbs(curr_Rates[1].close - BuyBuffer[1]))
           {
            return 0;
           }
         else
           {
            //Print("Support wins.");
            return 1;
           }
        }// if not then continue with the normal response.
      else
        {
         return 0;
        }
      //if(MathAbs(curr_Rates[1].close - BuyBuffer[1]) > MathAbs(curr_Rates[1].close - SellBuffer[1]))
      //  {
      //   return 1;
      //  }
      //else
      //  {
      //   return 0;
      //  }
      //return 0;
     }
   else
      if(curr_Rates[1].close >= BuyBuffer[1] && curr_Rates[1].close <= (BuyBuffer[1] + intervalZone*_Point))
        {
         //Print("Resistance Upper");
         // Resistance Zone: Upper Side

         // Check if the support is in the interval also
         if(curr_Rates[1].close >= SellBuffer[1] && curr_Rates[1].close <= (SellBuffer[1] + intervalZone*_Point) ||
            curr_Rates[1].close <= SellBuffer[1] && curr_Rates[1].close >= (SellBuffer[1] - intervalZone*_Point))
           {
            //Print("Support also");
            if(MathAbs(curr_Rates[1].close - SellBuffer[1]) > MathAbs(curr_Rates[1].close - BuyBuffer[1]))
              {
               return 0;
              }
            else
              {
               //Print("Support wins.");
               return 1;
              }
           }// if not then continue with the normal response.
         else
           {
            return 0;
           }

        }
      else
         if(curr_Rates[1].close >= SellBuffer[1] && curr_Rates[1].close <= (SellBuffer[1] + intervalZone*_Point))
           {
            //Print("Support Upper");
            // Support Zone: Upper Side

            // Check if the resistance is in the interval also
            if(curr_Rates[1].close <= BuyBuffer[1] && curr_Rates[1].close >= (BuyBuffer[1]-intervalZone*_Point) ||
               curr_Rates[1].close >= BuyBuffer[1] && curr_Rates[1].close <= (BuyBuffer[1]+intervalZone*_Point))
              {
               //Print("Resistance also.");
               if(MathAbs(curr_Rates[1].close - SellBuffer[1]) > MathAbs(curr_Rates[1].close - BuyBuffer[1]))
                 {
                  //Print("Resistance wins.");
                  return 0;
                 }
               else
                 {
                  return 1;
                 }
              }// if not then continue with the normal response.
            else
              {
               return 1;
              }

           }
         else
            if(curr_Rates[1].close <= SellBuffer[1] && curr_Rates[1].close >= (SellBuffer[1] - intervalZone*_Point))
              {
               //Print("Support Lower");
               // Support Zone: Lower Side

               // Check if the resistance is in the interval also
               if(curr_Rates[1].close <= BuyBuffer[1] && curr_Rates[1].close >= (BuyBuffer[1] - intervalZone*_Point) ||
                  curr_Rates[1].close >= BuyBuffer[1] && curr_Rates[1].close <= (BuyBuffer[1] + intervalZone*_Point))
                 {
                  // if it is, then check the closest zone and take its side
                  //Print("Resistance also.");
                  if(MathAbs(curr_Rates[1].close - SellBuffer[1]) > MathAbs(curr_Rates[1].close - BuyBuffer[1]))
                    {
                     Print("Resistance wins.");
                     return 0;
                    }
                  else
                    {
                     return 1;
                    }
                 }// if not then continue with the normal response.
               else
                 {
                  return 1;
                 }
              }
            else
              {
               return -1;
              }

  }


//+------------------------------------------------------------------+
//|  Close Current Order                                             |
//+------------------------------------------------------------------+
void CancelOrder()
  {
//trade.OrderDelete(ticketOrder);
   for(int i=PositionsTotal(); i>=0; i--)
     {
      if(Symbol()==PositionGetSymbol(i))
        {
         // get ticket number
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);

         //// get current stop loss
         //double currentStopLoss = PositionGetDouble(POSITION_SL);

         // Modify Stpo loss
         trade.PositionClose(PositionTicket);

         trade.PrintResult();
         //trade.
        }
     }

  }

//+------------------------------------------------------------------+
//| ORDER_TYPE ==> BUY LIMIT CODE: 2 ; SELL LIMIT CODE: 3 ;;  BUY STOP CODE: 4 ; SELL STOP CODE: 5
//+------------------------------------------------------------------+
void ChangeOrderDirection(int MarketDirection_M5, int MarketDirection_H1, int MarketDirection_H4, int BreakStruTrendLine_H1)
  {
// Positoins are live where as Orders are all of them, even pending orders
   double new_Stop_Loss = 0;
   double new_TakeProfit = 0;
   double new_Price = 0;
   for(int i=PositionsTotal(); i>=0; i--)
     {

      if(Symbol()==PositionGetSymbol(i))
        {
         // get ticket number
         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);

         //// get current stop loss
         //double currentStopLoss = PositionGetDouble(POSITION_SL);

         // Modify Stop loss
         ////trade.PositionClose(PositionTicket);
         //Print("TP    : "+PositionGetDouble(POSITION_TP)+"   ticket: "+ PositionGetInteger(POSITION_TICKET));

         // Open a new
         //PositionGetDouble();

         //trade.PrintResult();
         //trade.
        }
     }

   for(int i=0; i<OrdersTotal(); i++)
     {
      // get ticket number
      ulong OrderTicket = OrderGetTicket(i);
      //Print("TP   Not yet : "+OrderGetDouble(ORDER_TP)+"   ticket: "+ OrderGetInteger(ORDER_TICKET)+" posTota: "+OrdersTotal());
      //if(OrderGetInteger(ORDER_TYPE )
      //  {
      //Print("True TYPE: "+ OrderGetInteger(ORDER_TYPE));
      //}
      if(BreakStruTrendLine_H1 == 1 && MarketDirection_H1 == 0)
        {
         if(MarketDirection_M5 == 1)
           {

            // If it's a sell limit, then convert it to BUY stop;
            if(OrderGetInteger(ORDER_TYPE) == 3)
              {
               new_TakeProfit = OrderGetDouble(ORDER_TP);
               new_Price = OrderGetDouble(ORDER_PRICE_OPEN);
               trade.OrderDelete(OrderTicket);
               trade.BuyStop(1,new_Price,
                             Symbol(),0,new_Price + 10*_Point,0,0,"StraT_0011Buy");
               //trade.SellStop(1,Support_and_Resistance_Prices(indicator_handleSupRes_M5,1,0),
               //               Symbol(),0,Support_and_Resistance_Prices(indicator_handleSupRes_M5,1,0) - 10*_Point,0,0,"StraT_0000");


              }
           }
        }
      if(BreakStruTrendLine_H1 == 0 && MarketDirection_H1 == 1)
        {
         if(MarketDirection_M5 == 0)
           {
            // If it's a buy limit, then convert it to Sell stop;
            if(OrderGetInteger(ORDER_TYPE) == 2)
              {
               new_TakeProfit = OrderGetDouble(ORDER_TP);
               new_Price = OrderGetDouble(ORDER_PRICE_OPEN);
               trade.OrderDelete(OrderTicket);
               trade.SellStop(1,new_Price,
                              Symbol(),0,new_Price - 10*_Point,0,0,"StraT_0011Sell");
               //trade.SellStop(1,Support_and_Resistance_Prices(indicator_handleSupRes_M5,1,0),
               //               Symbol(),0,Support_and_Resistance_Prices(indicator_handleSupRes_M5,1,0) - 10*_Point,0,0,"StraT_0000");


              }
           }
        }

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool volume_Already_Exists(double volume_trade)
  {
   for(int i=0; i<OrdersTotal(); i++)
     {
      // get ticket number
      ulong OrderTicket = OrderGetTicket(i);
      Print("volume current: "+OrderGetDouble(ORDER_VOLUME_CURRENT));
      if(OrderGetDouble(ORDER_VOLUME_CURRENT) == volume_trade)
        {
         return true;
        }



     }
   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Delete_All_Orders(string strategy_comment)
  {

   for(int i=0; i<OrdersTotal(); i++)
     {
      //if(strategy_comment == OrderGetString(ORDER_COMMENT))
      //  {

      // get ticket number
      ulong OrderTicket = OrderGetTicket(i);
      Print("Ticket: "+OrderTicket + " comment: "+strategy_comment+" and "+ OrderGetString(ORDER_COMMENT));
      trade.OrderDelete(OrderTicket);
      //}



     }

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Delete_All_Positions(string strategy_comment)
  {
   for(int i=0; i<PositionsTotal(); i++)
     {
      //if(strategy_comment == PositionGetString(POSITION_COMMENT))
      //  {
      // get ticket number
      ulong PositionTicket = PositionGetTicket(i);

      Print("Ticket: Positions "+PositionTicket + " comment: "+strategy_comment+" and "+ PositionGetString(POSITION_COMMENT));

      trade.PositionClose(PositionTicket);
      //}

     }

  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Profits_Summation_Positions()
  {
   double sum_Profits = 0;
   if(PositionSelect(Symbol()) == true)
      for(int i=0; i<PositionsTotal(); i++)
        {
         sum_Profits += PositionGetDouble(POSITION_PROFIT);


        }
   return sum_Profits;
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//bool ExistPositionBuyStop()
//  {
//   for(int i=0; i<OrdersTotal(); i++)
//     {
//      if(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
//        {
//         if(OrderSymbol()==Symbol() && OrderType()==OP_BUYSTOP && OrderMagicNumber()==MagicNo)
//           {
//            return(true);
//           }
//        }
//     }
//   return(false);
//  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int getCandleTheSizeOf(MqlRates &ratesCurr[], int Area)
  {
   if(MathAbs(ratesCurr[1].high - ratesCurr[1].low) <= Area*_Point)
     {
      return 1;
     }
   return -1;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Fibonacci_Status(int indicator_handleFibo_R, ENUM_TIMEFRAMES period)
  {

   MqlRates ratesCurr[];
   ArraySetAsSeries(ratesCurr,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),ratesCurr);

   double f_1[];
   double f_2[];
   double f_3[];
   double f_4[];
   double f_5[];
   double f_6[];
   double f_7[];
   double f_8[];

   ArraySetAsSeries(f_1, true);
   ArraySetAsSeries(f_2, true);
   ArraySetAsSeries(f_3, true);
   ArraySetAsSeries(f_4, true);
   ArraySetAsSeries(f_5, true);
   ArraySetAsSeries(f_6, true);
   ArraySetAsSeries(f_7, true);
   ArraySetAsSeries(f_8, true);

   CopyBuffer(indicator_handleFibo_R,0,0,3,f_1);
   CopyBuffer(indicator_handleFibo_R,1,0,3,f_2);
   CopyBuffer(indicator_handleFibo_R,2,0,3,f_3);// 38.2
   CopyBuffer(indicator_handleFibo_R,3,0,3,f_4);// 50
   CopyBuffer(indicator_handleFibo_R,4,0,3,f_5);// 61.8
   CopyBuffer(indicator_handleFibo_R,5,0,3,f_6);// 76.4
   CopyBuffer(indicator_handleFibo_R,6,0,3,f_7);// 88.6
   CopyBuffer(indicator_handleFibo_R,7,0,3,f_8);

//Print("f[7]: "+f_7[1]);

   if((ratesCurr[1].close <= f_5[1] && ratesCurr[1].close >= f_3[1]) || (ratesCurr[1].high >= f_5[1] && ratesCurr[1].low <= f_5[1])
      || (ratesCurr[1].high >= f_3[1] && ratesCurr[1].low <= f_3[1]))
     {
      return 1;
     }



   return -1;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Checks if last candles were the one to start the res_supp bullets price
//+------------------------------------------------------------------+
int SP_Bullets_AreaCheck(ENUM_TIMEFRAMES period, double CurrSupport_Price, double CurrResistance_Price)
  {
   MqlRates ratesCurr[];
   ArraySetAsSeries(ratesCurr,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),ratesCurr);


   if(ratesCurr[1].high == CurrResistance_Price || ratesCurr[2].high == CurrResistance_Price)
     {
      return 0;
     }
   else
      if(ratesCurr[1].low == CurrSupport_Price || ratesCurr[2].low == CurrSupport_Price)
        {
         return 1;
        }
      else
        {
         return -1;
        }

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Support_Resistance_Zones_Buy(int indicator_handleSupRes_R, int index)
  {
   double SellBuffer[];
   ArraySetAsSeries(SellBuffer, true);


   CopyBuffer(indicator_handleSupRes_R,0,0,50,SellBuffer);

   return SellBuffer[index];

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Support_Resistance_Zones_Sell(int indicator_handleSupRes_R, int index)
  {

   double BuyBuffer[];

   ArraySetAsSeries(BuyBuffer,true);


   CopyBuffer(indicator_handleSupRes_R,1,0,50,BuyBuffer);
   return BuyBuffer[index];

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CheckNewBar(ENUM_TIMEFRAMES period_To_Use)
  {
   MqlRates      current_rates[];
   CopyRates(Symbol(),period_To_Use,0,1,current_rates);
   double current_volume = (const)current_rates[0].tick_volume;

   ResetLastError();
   if(CopyRates(Symbol(),period_To_Use,0,1,current_rates)!=1)
     {
      //Print("CopyRates copy error, Code = ",GetLastError());
      return(0);
     }

   if(current_rates[0].tick_volume>1)
     {
      return(0);
     }
   return(1);
  }
//+------------------------------------------------------------------+


const double XAG_USD_MagicNumber =5;
const double GBP_AUD_MagicNumber =0.673980;
const double XAU_USD_MagicNumber = 1;
const double EUR_USD_MagicNumber = 1;
const double USD_JPY_MagicNumber = 0.910341;
const double GBP_JPY_MagicNumber =0.910341;
const double USD_CAD_MagicNumber = 0.752819;
const double BTC_USD_MagicNumber = 0.000896;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Buying_Volume(const double amt_to_risk, const double curr_SL, const double curr_Ask)
  {
   double magicNumberChosen;
   if(Symbol() == "EURUSD")
     {
      magicNumberChosen = EUR_USD_MagicNumber;
      //Print("iT IS SIR");
     }
   else
      if(Symbol() == "XAUUSD")
        {
         magicNumberChosen = XAU_USD_MagicNumber;
         //Print("iT IS SIR GOLD");
        }
      else
         if(Symbol() == "XAGUSD")
           {
            magicNumberChosen = XAG_USD_MagicNumber;
           }
         else
            if(Symbol() == "GBPAUD")
              {
               magicNumberChosen = GBP_AUD_MagicNumber;
              }
            else
               if(Symbol() == "USDJPY")
                 {
                  magicNumberChosen = USD_JPY_MagicNumber;
                  //Print("iT IS SIR GOLD");
                 }
               else
                  if(Symbol() == "GBPJPY")
                    {
                     magicNumberChosen = GBP_JPY_MagicNumber;
                    }
                  else
                     if(Symbol() == "USDCAD")
                       {
                        magicNumberChosen = USD_CAD_MagicNumber;
                       }
                     else
                        if(Symbol() == "BTCUSD")
                          {
                           magicNumberChosen = BTC_USD_MagicNumber;
                          }
                        else
                           if(Symbol() == "BTCEUR")
                             {
                              magicNumberChosen = BTC_USD_MagicNumber;
                             }
                           //else
                           //   if(Symbol() == "US30.cash")
                           //     {
                           //      magicNumberChosen = 13.7665;
                           //     }
                           else
                             {
                              magicNumberChosen = 1;
                             }
//Print("currSL: "+curr_SL);
//Print("current SL: "+PositionGetDouble(POSITION_SL));
   double pips = (MathAbs(curr_Ask - curr_SL)*MathPow(10,_Digits));
   double result = NormalizeDouble((amt_to_risk/(magicNumberChosen*pips)),2);


//Print("tHE PIPS: "+pips);


   return result;
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Selling_Volume(const double amt_to_risk, const double curr_SL, const double curr_Bid)
  {
   double magicNumberChosen;
   if(Symbol() == "EURUSD")
     {
      magicNumberChosen = EUR_USD_MagicNumber;
      //Print("iT IS SIR");
     }
   else
      if(Symbol() == "XAUUSD")
        {
         magicNumberChosen = XAU_USD_MagicNumber;
         //Print("iT IS SIR GOLD");
        }
      else
         if(Symbol() == "XAGUSD")
           {
            magicNumberChosen = XAG_USD_MagicNumber;
           }
         else
            if(Symbol() == "GBPAUD")
              {
               magicNumberChosen = GBP_AUD_MagicNumber;
              }
            else
               if(Symbol() == "USDJPY")
                 {
                  magicNumberChosen = USD_JPY_MagicNumber;
                  //Print("iT IS SIR GOLD");
                 }
               else
                  if(Symbol() == "GBPJPY")
                    {
                     magicNumberChosen = GBP_JPY_MagicNumber;
                    }
                  else
                     if(Symbol() == "USDCAD")
                       {
                        magicNumberChosen = USD_CAD_MagicNumber;
                       }
                     else
                        if(Symbol() == "BTCUSD")
                          {
                           magicNumberChosen = BTC_USD_MagicNumber;
                          }
                        else
                           if(Symbol() == "BTCEUR")
                             {
                              magicNumberChosen = BTC_USD_MagicNumber;
                             }
                           //else
                           //   if(Symbol() == "US30.cash")
                           //     {
                           //      magicNumberChosen = 13.7665;
                           //     }
                           else
                             {
                              magicNumberChosen = 1;
                             }

   double pips = (MathAbs(curr_Bid - curr_SL)*MathPow(10,_Digits));

   double result = NormalizeDouble((amt_to_risk/(magicNumberChosen*pips)),2);


//Print("tHE PIPS: "+pips);

//Print("Normalized: "+ NormalizeDouble((amt_to_risk/(XAU_USD_MagicNumber*pips)),2));
   return result;
  }
//+------------------------------------------------------------------+

int triggeredSLEarly = -1;
bool changedSL = false;
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
   if(HistoryDealSelect(trans.deal) == true)
     {
      ENUM_DEAL_ENTRY deal_entry=(ENUM_DEAL_ENTRY) HistoryDealGetInteger(trans.deal,DEAL_ENTRY);
      ENUM_DEAL_REASON deal_reason=(ENUM_DEAL_REASON) HistoryDealGetInteger(trans.deal,DEAL_REASON);
      PrintFormat("deal entry type=%s trans type=%s trans deal type=%s order-ticket=%d deal-ticket=%d deal-reason=%s"
                  ,EnumToString(deal_entry),EnumToString(trans.type)
                  ,EnumToString(trans.deal_type),trans.order,trans.deal
                  ,EnumToString(deal_reason));
      if(EnumToString(deal_reason) == "DEAL_REASON_SL")
        {
         triggeredSLEarly = 1;
         Print("ticket ",trans.order, "  triggered SL");
        }
      else
        {
         //triggeredSLEarly = -1;
        }


      if(EnumToString(deal_reason) == "DEAL_REASON_TP")
        {
         triggeredTP = 1;
         Print("ticket ",trans.order, "  triggered TP");
        }
      else
        {
         //triggeredSLEarly = -1;
        }

      if(EnumToString(deal_entry) == "DEAL_ENTRY_IN" && PositionsTotal() >= 2)
        {
         triggeredPosition = 1;
         Print("ticket ",trans.order, "  triggered Position deal Entry: ",EnumToString(deal_entry));
         //Print("rates[0]: "+PositionGetDouble(POSITION_PRICE_OPEN));

         // If a buy positon is opened, immediately add a sell Limit at TradesIncrement Step from that trade.
         //if(EnumToString(trans.deal_type) == "DEAL_TYPE_BUY")
         //  {
         //   trade.SellLimit(Volume_Chosen,rates[0].close + Trades_Increment_Step*_Point,Symbol(),
         //                   0,rates[0].close + Trades_Increment_Step*_Point - Trades_Increment_Step*_Point,0,0,"Retrieve Strat00");
         //  }
         //if(EnumToString(trans.deal_type) == "DEAL_TYPE_SELL")
         //  {
         //   trade.BuyLimit(Volume_Chosen,rates[0].close - Trades_Increment_Step*_Point,Symbol(),
         //                  0,rates[0].close - Trades_Increment_Step*_Point + Trades_Increment_Step*_Point,0,0,"Retrieve Strat00");
         //  }

         //      trade.BuyLimit(Volume_Chosen,Ask_Price - i*Trades_Increment_Step*_Point,Symbol(),
         //                     0,Ask_Price - i*Trades_Increment_Step*_Point + Trades_Increment_Step*_Point,0,0,comment_strat);
         //
         //      trade.SellLimit(Volume_Chosen,Ask_Price + i*Trades_Increment_Step*_Point,Symbol(),
         //                      0,Ask_Price + i*Trades_Increment_Step*_Point - Trades_Increment_Step*_Point,0,0,comment_strat);

        }


      else
        {
         //triggeredSLEarly = -1;
        }
      //2021.12.29 15:18:36.493 2021.04.01 01:00:12   deal entry type=DEAL_ENTRY_IN trans type=TRADE_TRANSACTION_DEAL_ADD trans deal type=DEAL_TYPE_BUY order-ticket=4 deal-ticket=4 deal-reason=DEAL_REASON_EXPERT
      //      if(AccountInfoDouble(ACCOUNT_EQUITY) > AccountInfoDouble(ACCOUNT_BALANCE))
      //        {
      //         CancelOrder(trans.deal);
      //
      //        }

     }

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
int triggeredPosition = -1;
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
