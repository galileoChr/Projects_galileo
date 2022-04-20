//+------------------------------------------------------------------+
//|                                              Testing_Advisor.mq5 |
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

int indicator_customMA_MN1_1, indicator_customMA_MN1_2,indicator_customMA_D1_1,indicator_customMA_D1_2;
int indicator_customMA_H4_1,indicator_customMA_H4_2,indicator_customMA_H1_1,indicator_customMA_H1_2;
int indicator_customMA_M30_1,indicator_customMA_M30_2,indicator_customMA_M15_1,indicator_customMA_M15_2;
int indicator_customMA_M5_1,indicator_customMA_M5_2;

int indicator_Trending_Angle_H1_1, indicator_Trending_Angle_H4_1, indicator_Trending_Angle_M5_1, indicator_Trending_Angle_M15_1;
int indicator_Trending_Angle_D1_1, indicator_Trending_Angle_MN1_1, indicator_Trending_Angle_M30_1;
int indicator_Trending_Angle_H1_2, indicator_Trending_Angle_H4_2, indicator_Trending_Angle_M5_2, indicator_Trending_Angle_M15_2;
int indicator_Trending_Angle_D1_2, indicator_Trending_Angle_MN1_2, indicator_Trending_Angle_M30_2;

int indicator_handleRetests_H1, indicator_handleRetests_H4, indicator_handleRetests_D1, indicator_handleRetests_MN1 ;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   adx_indicator_handle_H1 = iCustom(Symbol(),PERIOD_H1,"Custom_ADX"
                                    );
   adx_indicator_handle_D1 = iCustom(Symbol(),PERIOD_D1,"Custom_ADX"
                                    );
   adx_indicator_handle_H4 = iCustom(Symbol(),PERIOD_H4,"Custom_ADX"
                                    );
   adx_indicator_handle_M30 = iCustom(Symbol(),PERIOD_M30,"Custom_ADX"
                                     );
   indicator_customMA_D1_1 = iCustom(Symbol(),PERIOD_D1,"Custom Moving Average_1",8);
   indicator_customMA_D1_2 = iCustom(Symbol(),PERIOD_D1,"Custom Moving Average_2",14);
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

//iCustom(Symbol(),PERIOD_W1,"MQLTA MT5 Support Resistance Lines_2");
//indicator_handlePivot_MN1_vis_to_MN1 = iCustom(Symbol(),PERIOD_MN1,"pivot",PERIOD_MN1);
//indicator_handlePivot_MN1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot",PERIOD_MN1);
//indicator_handlePivot_MN1_vis_to_H4 = iCustom(Symbol(),PERIOD_H4,"pivot",PERIOD_MN1);
   indicator_handlePivot_H4_vis_to_M5 = iCustom(Symbol(),PERIOD_M5,"pivot - H4",PERIOD_H4);
   indicator_handlePivot_MN1_vis_to_M5 = iCustom(Symbol(),PERIOD_M5,"pivot - MN1",PERIOD_MN1);
   indicator_handlePivot_D1_vis_to_M5 = iCustom(Symbol(),PERIOD_M5,"pivot - D1",PERIOD_D1);
   indicator_handlePivot_MN1_vis_to_D1 = iCustom(Symbol(),PERIOD_D1,"pivot - MN1",PERIOD_MN1);
   indicator_handlePivot_MN1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - MN1",PERIOD_MN1);
   indicator_handlePivot_D1_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - D1",PERIOD_D1);
//indicator_handlePivot_H4_vis_to_H1 = iCustom(Symbol(),PERIOD_H1,"pivot - H4",PERIOD_H4);

//indicator_handlePTL_2_H1 = iCustom(Symbol(),PERIOD_H1,"PTL (2)");
   indicator_handlePTL_2_M5 = iCustom(Symbol(),PERIOD_M5,"PTL (2)");
   indicator_handlePTL_2_M15 = iCustom(Symbol(),PERIOD_M15,"PTL (2)");
//indicator_handlePTL_2_H1 = iCustom(Symbol(),PERIOD_H1,"PTL (2)");
   indicator_handlePTL_2_H4 = iCustom(Symbol(),PERIOD_H4,"PTL (2)");
//indicator_handlePTL_2_D1 = iCustom(Symbol(),PERIOD_D1,"PTL (2)");


   indicator_handleSupRes_H4 =iCustom(Symbol(),PERIOD_H4,"Support_and_Resistance");
   indicator_handleSupRes_D1 = iCustom(Symbol(),PERIOD_D1,"Support_and_Resistance");
   indicator_handleSupRes_H1 = iCustom(Symbol(),PERIOD_H1,"Support_and_Resistance");
   indicator_handleSupRes_MN = iCustom(Symbol(),PERIOD_MN1,"Support_and_Resistance");
   indicator_handleSupRes_M5 = iCustom(Symbol(),PERIOD_M5,"Support_and_Resistance");

   indicator_handlePatterns_H4 = iCustom(Symbol(),PERIOD_H4,"patterns_on_chart");
   indicator_handlePatterns_D1 = iCustom(Symbol(),PERIOD_D1,"patterns_on_chart");
   indicator_handlePatterns_H1 = iCustom(Symbol(),PERIOD_H1,"patterns_on_chart");
//indicator_handlePatterns_MN1 = iCustom(Symbol(),PERIOD_MN1,"patterns_on_chart");
   indicator_handlePatterns_M5 = iCustom(Symbol(),PERIOD_M5,"patterns_on_chart");
   indicator_handlePatterns_M15 = iCustom(Symbol(),PERIOD_M15,"patterns_on_chart");
   indicator_handlePatterns_M30 = iCustom(Symbol(),PERIOD_M30,"patterns_on_chart");
//iCustom(Symbol(),PERIOD_M5,"patterns_on_chart");

//indicator_handleRetests_H1 = iCustom(Symbol(),PERIOD_H1,"shved_supply_and_demand_v1.4");
   indicator_handleRetests_H4 = iCustom(Symbol(),PERIOD_H4,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_D1 = iCustom(Symbol(),PERIOD_D1,"shved_supply_and_demand_v1.4");
//indicator_handleRetests_MN1 = iCustom(Symbol(),PERIOD_MN1,"shved_supply_and_demand_v1.4");


   indicator_Trending_Angle_H1_1 = iCustom(Symbol(),PERIOD_H1,"s_rind_D",4,300,30,70,13.0);
//indicator_Trending_Angle_H1_2 = iCustom(Symbol(),PERIOD_H1,"s_rind_D_2",8,500,30,70,13.0);

   indicator_Trending_Angle_M5_1 = iCustom(Symbol(),PERIOD_M5,"s_rind_D",4,300,30,70,13.0);
//indicator_Trending_Angle_M5_2 = iCustom(Symbol(),PERIOD_M5,"s_rind_2",2,500,30,70,13.0);

   indicator_Trending_Angle_H4_1 = iCustom(Symbol(),PERIOD_H4,"s_rind_D",4,300,30,70,13.0);
//indicator_Trending_Angle_H4_2 = iCustom(Symbol(),PERIOD_H4,"s_rind_2",8,500,30,70,13.0);

   indicator_Trending_Angle_D1_1 = iCustom(Symbol(),PERIOD_D1,"s_rind_D",4,300,30,70,13.0);
//indicator_Trending_Angle_D1_2 = iCustom(Symbol(),PERIOD_D1,"s_rind_D_2",8,500,30,70,13.0);

   indicator_Trending_Angle_MN1_1 = iCustom(Symbol(),PERIOD_MN1,"s_rind_D",4,300,30,70,13.0);
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

int BuyStrategiesCategory[70][25];
int SellStrategiesCategory[70][25];
const int DEFAULT_NUMBER_ENTRIES = 25;
const int DEFAULT_NUMBER_STRATEGIES = 70;
int rowCounterBuy = 0;
int rowCounterSell = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Strategies_Inventories(int strategy_reference)
  {
//if(rowCounterBuy > 15)
//  {
//   ArrayResize(BuyStrategiesCategory,rowCounterBuy);
//  }
// Check first that the numbers of rows available are not beyond the capacities of the Categories.
   if(rowCounterBuy < (DEFAULT_NUMBER_STRATEGIES -1))
     {
      // Check when the reference is activated/trade started
      if(strategy_reference == 1)
        {
         // Then check if similar strategies exist in the BuyCategory invetory. If yes, then activate the reward system.
         if(checkRepeatStrategies_Buy(Default_Entry_Confluences,strategy_reference) == true)
           {
            // Reward please...

            //Print("SimilarityRowNumberBuy: "+SimilarityRowNumberBuy+" with "+rowCounterBuy);
            rowNumber_Status_BuyArray[rowNumberPosition_BuyCounter] = SimilarityRowNumberBuy;
            rowNumberPosition_BuyCounter++;

            Print("BuyStrategiesCategory: ");
            //ArrayPrint(BuyStrategiesCategory);

           }
         else
           {
            //Else fill the category specific row(rowCounter) with a strategy (lists of full of confluences-status)
            for(int i=0 ; i<DEFAULT_NUMBER_ENTRIES; i++)
              {
               BuyStrategiesCategory[rowCounterBuy][i] = Default_Entry_Confluences[i];
              }

            rowNumber_Status_BuyArray[rowNumberPosition_BuyCounter] = rowCounterBuy;
            rowNumberPosition_BuyCounter++;

            rowCounterBuy++;


            Print("BuyStrategiesCategory: ");
            //ArrayPrint(BuyStrategiesCategory);


           }


        }
      else {}
     }
   else
     {
      //Stop filling the rows.
      Print("Max Rows filled....BuyCategory");
     }

   if(rowCounterSell < (DEFAULT_NUMBER_STRATEGIES -1))
     {
      if(strategy_reference == 0)
        {
         // Then check if similar strategies exist in the SellCategory invetory. If yes, then activate the reward system.
         if(checkRepeatStrategies_Sell(Default_Entry_Confluences,strategy_reference) == true)
           {
            // Reward please...

            //Print("SimilarityRowNumberSell: "+SimilarityRowNumberSell+" with "+rowCounterSell);
            rowNumber_Status_SellArray[rowNumberPosition_SellCounter] = SimilarityRowNumberSell;
            Print("SellStrategiesCategory: "+rowNumberPosition_SellCounter+" "+rowCounterSell);
            rowNumberPosition_SellCounter++;

            //ArrayPrint(SellStrategiesCategory);

           }
         else
           {
            // Fill the category specific row(rowCounter) with a strategy (lists of full of confluences-status)
            for(int j=0 ; j<DEFAULT_NUMBER_ENTRIES; j++)
              {
               SellStrategiesCategory[rowCounterSell][j] = Default_Entry_Confluences[j];
              }
            rowNumber_Status_SellArray[rowNumberPosition_SellCounter] = rowCounterSell;
            Print("SellStrategiesCategory: "+rowNumberPosition_SellCounter+" "+rowCounterSell);
            rowNumberPosition_SellCounter++;
            rowCounterSell++;

            //ArrayPrint(SellStrategiesCategory);

           }

        }
      else
        {
        }
     }
   else
     {
      //Stop filling the rows.
      Print("Max Rows filled....SellCategory");
     }


  }



int similarityCounter_Buy = 0;
int similariyCounter_Sell = 0;
int SimilarityRowNumberBuy = 0;
int SimilarityRowNumberSell = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool checkRepeatStrategies_Buy(int &newDefaultEntries[], int strategyReference)
  {
   int rowEntry = 0;
//for(int rowEntry = 0; rowEntry < rowCounterBuy; rowEntry++)
//  {
   for(int colEntry = 0; colEntry < DEFAULT_NUMBER_ENTRIES; colEntry++)
     {
      //ArrayCompare(newDefaultEntries,BuyStrategiesCategory,0,0,25);
      if(newDefaultEntries[colEntry] != BuyStrategiesCategory[rowEntry][colEntry])
        {
         // Then go to next row
         colEntry = 0;
         if(rowEntry<DEFAULT_NUMBER_STRATEGIES-1)
           {
            rowEntry++;
           }
         else   // Add new Confluence in BuyCategory
           {
            return false;
           }



        }


     }

// It is equal strategies, then add reward to appropriate rowEntry.

   similarityCounter_Buy++;
   SimilarityRowNumberBuy = rowEntry;
   return true;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool checkRepeatStrategies_Sell(int &newDefaultEntries[], int strategyReference)
  {
   int rowEntry = 0;

   for(int colEntry = 0; colEntry < DEFAULT_NUMBER_ENTRIES; colEntry++)
     {
      if(newDefaultEntries[colEntry] != SellStrategiesCategory[rowEntry][colEntry])
        {

         // Then go to next row
         colEntry = 0;
         if(rowEntry<DEFAULT_NUMBER_STRATEGIES-1)
           {
            rowEntry++;
           }
         else   // Add new Confluence in SellCategory
           {
            return false;
           }
        }


     }

// It is equal strategies, then add reward to appropriate rowEntry.

   similariyCounter_Sell++;
   SimilarityRowNumberSell = rowEntry;
   return true;


  }



int SellCategoryRewardArray[70];
int BuyCategoryRewardArray[70];
int BuyCategoryRewardCounter=0;
int SellCategoryRewardCounter = 0;
//+------------------------------------------------------------------+
//|This method keeps track of which strategy has the best points so far|
//+------------------------------------------------------------------+
void RewardSystem(MqlRates &ratesCurr[])
  {
// Take the SL and TP, then


//Print("RewardSystem_Buy");
//ArrayPrint(RewardSystem_Buy);
   for(int i=0; i<ArraySize(orderNumber_Status_Buy); i++)
     {
      //Print("rowNumber_Status_BuyArray["+i+"]: "+rowNumber_Status_BuyArray[i]);
      if(counter_OrderInfo_Buy > 0)
        {
         if((Price_TP_Buy[i] <= ratesCurr[1].close || Price_TP_Buy[i] <= ratesCurr[1].high) && Price_TP_Buy[i] !=0)
           {

            RewardSystem_Buy[rowNumber_Status_BuyArray[i]] += 1;
            //ArrayFill(orderNumber_Status_Buy,0,21,0);
            ObjectDelete(0,DoubleToString(Price_TP_Buy[i]));
            ObjectDelete(0,DoubleToString(Price_SL_Buy[i])); // Delete the Horiz. line
            ObjectDelete(0,DoubleToString(orderNumber_Status_Buy[i]));
            orderNumber_Status_Buy[i] = 0;
            Price_TP_Buy[i] = 0;



            --rowNumberPosition_BuyCounter;
            --counter_OrderInfo_Buy;

           }
         else
            if((Price_SL_Buy[i] >= ratesCurr[1].close || Price_SL_Buy[i] >= ratesCurr[1].low) && Price_SL_Buy[i] !=0)
              {

               RewardSystem_Buy[rowNumber_Status_BuyArray[i]] += -1;
               ObjectDelete(0,DoubleToString(Price_SL_Buy[i])); // Delete the Horiz. line
               ObjectDelete(0,DoubleToString(Price_TP_Buy[i])); // Delete the Horiz. line
               ObjectDelete(0,DoubleToString(orderNumber_Status_Buy[i]));
               orderNumber_Status_Buy[i] = 0;
               Price_SL_Buy[i] = 0;

               --rowNumberPosition_BuyCounter;
               --counter_OrderInfo_Buy;

              }
        }

     }

//Print("RewardSystem_sELL");
//ArrayPrint(RewardSystem_Sell);

   for(int i=0; i<ArraySize(orderNumber_Status_Sell); i++)
     {
      //Print("rowNumber_Status_SellArray["+i+"]: "+rowNumber_Status_SellArray[i]);
      if(counter_OrderInfo_Sell > 0)
        {
         if((Price_TP_Sell[i] >= ratesCurr[1].close || Price_TP_Sell[i] >= ratesCurr[1].low) && Price_TP_Sell[i] !=0)
           {


            RewardSystem_Sell[rowNumber_Status_SellArray[i]] += 1;
            ObjectDelete(0,DoubleToString(orderNumber_Status_Sell[i]));
            ObjectDelete(0,DoubleToString(Price_TP_Sell[i])); // Delete the Horiz. line
            ObjectDelete(0,DoubleToString(Price_SL_Sell[i])); // Delete the Horiz. line
            Price_TP_Sell[i] = 0;
            orderNumber_Status_Sell[i] = 0;


            --counter_OrderInfo_Sell;
            --rowNumberPosition_SellCounter;
           }
         else
            if((Price_SL_Sell[i] <= ratesCurr[1].close || Price_SL_Sell[i] <= ratesCurr[1].high) && Price_SL_Sell[i] !=0)
              {

               RewardSystem_Sell[rowNumber_Status_SellArray[i]] += -1;
               ObjectDelete(0,DoubleToString(Bid));
               ObjectDelete(0,DoubleToString(orderNumber_Status_Sell[i]));
               ObjectDelete(0,DoubleToString(Price_TP_Sell[i])); // Delete the Horiz. line
               ObjectDelete(0,DoubleToString(Price_SL_Sell[i])); // Delete the Horiz. line
               Price_SL_Sell[i] = 0;
               orderNumber_Status_Sell[i] = 0;


               --counter_OrderInfo_Sell;
               --rowNumberPosition_SellCounter;
              }
        }



     }




  }



int Default_Entry_Confluences[25];
int ConfluenceTeam[50];
string ConfluenceTeamDefinition[20];
MqlRates rates[];


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void create_Default_Entry_Confluences()
  {
// S_P_MN1(using pivots) and S_D_MN1:
   Default_Entry_Confluences[0] = ConfluenceTeam[16];
   Default_Entry_Confluences[1] = ConfluenceTeam[19];

// S_P_D1(using pivots), S_D_D1, PTL_D1, ADX_D1,
// PATTERN_D1, MA_CROSS_D1:
   Default_Entry_Confluences[2] = ConfluenceTeam[17];
   Default_Entry_Confluences[3] = ConfluenceTeam[20];
   Default_Entry_Confluences[4] = ConfluenceTeam[24];
   Default_Entry_Confluences[5] = ConfluenceTeam[22];
   Default_Entry_Confluences[6] = ConfluenceTeam[25];
   Default_Entry_Confluences[7] = ConfluenceTeam[26];

// S_P_H4(using pivots), S_D_H4, PTL_H4,
// ADX_H4, PATTERN_H4, MA_PriceAction_H4,
// MA_Cross_H4
   Default_Entry_Confluences[8] = ConfluenceTeam[18];
   Default_Entry_Confluences[9] = ConfluenceTeam[21];
   Default_Entry_Confluences[10] = ConfluenceTeam[12];
   Default_Entry_Confluences[11] = ConfluenceTeam[23];
   Default_Entry_Confluences[12] = ConfluenceTeam[6];
   Default_Entry_Confluences[13] = ConfluenceTeam[2];
   Default_Entry_Confluences[14] = ConfluenceTeam[27];

// S_D_H1, PATTERN_H1, MA_CROSS_H1,
// MA_PriceAction_H1, ADX_H1
   Default_Entry_Confluences[15] = ConfluenceTeam[13];
   Default_Entry_Confluences[16] = ConfluenceTeam[7];
   Default_Entry_Confluences[17] = ConfluenceTeam[28];
   Default_Entry_Confluences[18] = ConfluenceTeam[8];
   Default_Entry_Confluences[19] = ConfluenceTeam[3];

// MA_CROSS_M30
   Default_Entry_Confluences[20] = ConfluenceTeam[29];

// MA_CROSS_M15, PATTERN_M15
   Default_Entry_Confluences[21] = ConfluenceTeam[30];
   Default_Entry_Confluences[22] = ConfluenceTeam[11];

// MA_CROSS_M5, PATTERN_M5
   Default_Entry_Confluences[23] = ConfluenceTeam[0];
   Default_Entry_Confluences[24] = ConfluenceTeam[1];

//Default_Entry_Confluences[25] = ;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Check_SupportResistance_Period(int suppResi_Period)
  {
   if(suppResi_Period == 11)
     {

      return true;
     }

   else
     {
      return false;
     }
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Support_Resistance_Work(MqlRates &ratesCurr[])
  {
   if(Check_SupportResistance_Period(Pivot_Support_Resistance_Area_Check(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5)) == true)
     {
      ConfluenceTeam[16] = 1;
      ConfluenceTeamDefinition[13] = "MN1_SP";
     }
   else
     {
      ConfluenceTeam[16] = -1;
      ConfluenceTeamDefinition[13] = "/NA/";
     }

   if(Check_SupportResistance_Period(Pivot_Support_Resistance_Area_Check(indicator_handlePivot_D1_vis_to_M5,PERIOD_M5)) == true)
     {
      ConfluenceTeam[17] = 1;
      ConfluenceTeamDefinition[14] = "D1_SP";
     }
   else
     {
      ConfluenceTeam[17] = -1;
      ConfluenceTeamDefinition[14] = "/NA/";
     }

   if(Check_SupportResistance_Period(Pivot_Support_Resistance_Area_Check(indicator_handlePivot_H4_vis_to_M5,PERIOD_M5)) == true)
     {
      ConfluenceTeam[18] = 1;
      ConfluenceTeamDefinition[15] = "H4_SP";
     }
   else
     {
      ConfluenceTeam[18] = -1;
      ConfluenceTeamDefinition[15] = "/NA/";
     }
//     ************ ^^CONFLUNCE DEFINITION^^ ***********   //

   if(Support_Resistance_Area_Check(indicator_handleSupRes_MN,PERIOD_MN1) ==1
      ||
      Support_Resistance_Area_Check(indicator_handleSupRes_D1,PERIOD_D1) ==1 ||
      Support_Resistance_Area_Check(indicator_handleSupRes_H4,PERIOD_H4) ==1
     )
     {

      //Support_Resistance_Area_Check(indicator_handleSupRes_M5,PERIOD_M5) ==1
      ConfluenceTeam[4] = 1;
     }
   else
      if(Support_Resistance_Area_Check(indicator_handleSupRes_MN,PERIOD_MN1) ==0
         ||
         Support_Resistance_Area_Check(indicator_handleSupRes_D1,PERIOD_D1) ==0 ||
         Support_Resistance_Area_Check(indicator_handleSupRes_H4,PERIOD_H4) ==0
        )
        {

         //Support_Resistance_Area_Check(indicator_handleSupRes_M5,PERIOD_M5) ==0
         ConfluenceTeam[4] = 0;
        }
      else
        {
         ConfluenceTeam[4]=-1;
        }



// PIVOT visible to the base Period check...
   if(
      Pivot_Support_Resistance_Area_Check(indicator_handlePivot_H4_vis_to_M5,PERIOD_M5) == 11
      || Pivot_Support_Resistance_Area_Check(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5) == 11
      || Pivot_Support_Resistance_Area_Check(indicator_handlePivot_D1_vis_to_M5,PERIOD_M5) == 11
   )
     {
      ConfluenceTeam[5] = 1;
     }
   else
     {
      ConfluenceTeam[5] = -1;
     }

//Comment("Status:   "+Supply_Demand_Indicator(indicator_handleRetests_H1,ratesCurr));

// Supply-Demand Zones from MN1 to H1;

   if(Supply_Demand_Indicator(indicator_handleRetests_MN1,ratesCurr) >= 0)
     {
      ConfluenceTeam[19] = 1;
      //ConfluenceTeamDefinition[17] = "SUPPLY - DEMAND ZONE";
     }
   else
     {
      ConfluenceTeam[19] = -1;
      //ConfluenceTeamDefinition[17] = "NO SUPPLY - DEMAND ZONE";
     }

   if(Supply_Demand_Indicator(indicator_handleRetests_D1,ratesCurr) >= 0)
     {
      ConfluenceTeam[20] = 1;
      //ConfluenceTeamDefinition[17] = "SUPPLY - DEMAND ZONE";
     }
   else
     {
      ConfluenceTeam[20] = -1;
      //ConfluenceTeamDefinition[17] = "NO SUPPLY - DEMAND ZONE";
     }

   if(Supply_Demand_Indicator(indicator_handleRetests_H4,ratesCurr) >= 0)
     {
      ConfluenceTeam[21] = 1;
      //ConfluenceTeamDefinition[17] = "SUPPLY - DEMAND ZONE";
     }
   else
     {
      ConfluenceTeam[21] = -1;
      //ConfluenceTeamDefinition[17] = "NO SUPPLY - DEMAND ZONE";
     }

   if(Supply_Demand_Indicator(indicator_handleRetests_H1,ratesCurr) >= 0)
     {
      ConfluenceTeam[13] = 1;
      ConfluenceTeamDefinition[17] = "SUPPLY - DEMAND ZONE";
     }
   else
     {
      ConfluenceTeam[13] = -1;
      ConfluenceTeamDefinition[17] = "NO SUPPLY - DEMAND ZONE";
     }
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CandleStick_Patterns()
  {
//     ************ <<CONFLUNCE DEFINITION>> ***********   //

//     ************ ^^CONFLUNCE DEFINITION^^ ***********   //

// tEST upArrow and downArrow

// Checking the patterns of different Periods.
   if(Patterns_Up(indicator_handlePatterns_M5,1) > 0)
     {
      ConfluenceTeam[1] = 1;
      ConfluenceTeamDefinition[1] = "PATT_UP_M5";
     }
   else
      if(Patterns_Down(indicator_handlePatterns_M5,1) > 0)
        {
         ConfluenceTeam[1] = 0;
         ConfluenceTeamDefinition[1]="PATT_DOWN_M5";
        }

   if(Patterns_Up(indicator_handlePatterns_D1,1) > 0)
     {
      ConfluenceTeam[25] = 1;
      //ConfluenceTeamDefinition[7] = "PATT_UP_H1";
     }
   else
      if(Patterns_Down(indicator_handlePatterns_D1,1) > 0)
        {
         ConfluenceTeam[25] = 0;
         //ConfluenceTeamDefinition[7]="PATT_DOWN_H1";
        }

   if(Patterns_Up(indicator_handlePatterns_H4,1) > 0)
     {
      //Print("True Up");
      ConfluenceTeam[6] = 1;
      ConfluenceTeamDefinition[6]="PATT_UP_H4";
     }
   else
      if(Patterns_Down(indicator_handlePatterns_H4,1) > 0)
        {
         //Print("True Down");
         ConfluenceTeam[6] = 0;
         ConfluenceTeamDefinition[6]="PATT_DOWN_H4";
        }
//Print("Patterns_Down(indicator_handlePatterns_H4,1): "+Patterns_Down(indicator_handlePatterns_H4,1));
//Print("Patterns_Up(indicator_handlePatterns_H4,1): "+Patterns_Up(indicator_handlePatterns_H4,1));
   if(Patterns_Up(indicator_handlePatterns_H1,1) > 0)
     {
      ConfluenceTeam[7] = 1;
      ConfluenceTeamDefinition[7] = "PATT_UP_H1";
     }
   else
      if(Patterns_Down(indicator_handlePatterns_H1,1) > 0)
        {
         ConfluenceTeam[7] = 0;
         ConfluenceTeamDefinition[7]="PATT_DOWN_H1";
        }
////
//if(Patterns_Up(indicator_handlePatterns_M30,1) > 0)
//     {
//      ConfluenceTeam[26] = 1;
//      //ConfluenceTeamDefinition[11]="PATT_UP_M15";
//     }
//   else
//      if(Patterns_Down(indicator_handlePatterns_M30,1) > 0)
//        {
//         ConfluenceTeam[26] = 0;
//         //ConfluenceTeamDefinition[11]="PATT_DOWN_M15";
//        }

   if(Patterns_Up(indicator_handlePatterns_M15,1) > 0)
     {
      ConfluenceTeam[11] = 1;
      ConfluenceTeamDefinition[11]="PATT_UP_M15";
     }
   else
      if(Patterns_Down(indicator_handlePatterns_M15,1) > 0)
        {
         ConfluenceTeam[11] = 0;
         ConfluenceTeamDefinition[11]="PATT_DOWN_M15";
        }

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Market_Structure_Work()
  {
// We could use the ADX indicator and/or MA price action

// Checking Trending/Consolidation Status using ADX.
   if(Market_Structure(adx_indicator_handle_H1,PERIOD_H1) > 0)
     {
      // Means it is trending
      ConfluenceTeam[3] = 1;
      ConfluenceTeamDefinition[3]="TRENDING...H1";

     }
   else
     {
      // Means it is ranging/consolidating
      ConfluenceTeam[3] = -1;
      ConfluenceTeamDefinition[3]="CONSOLIDATING...H1";
     }

// Checks which direction it is trending
   if(Market_Structure_2(adx_indicator_handle_H1, PERIOD_H1) == 1)
     {
      // Means it is trending Up
      ConfluenceTeam[48] = 1;

     }
   else
      if(Market_Structure_2(adx_indicator_handle_H1, PERIOD_H1) == 0)
        {
         // Means it is trending Down
         ConfluenceTeam[48] = 0;

        }
      else
        {
         // Means it is ranging/consolidating
         ConfluenceTeam[48] = -1;
        }
        

// M30
   if(Market_Structure(adx_indicator_handle_M30,PERIOD_M30) > 0)
     {
      // Means it is trending
      ConfluenceTeam[45] = 1;

     }
   else
     {
      // Means it is ranging/consolidating
      ConfluenceTeam[45] = -1;
     }

// Checks which direction it is trending
   if(Market_Structure_2(adx_indicator_handle_M30, PERIOD_M30) == 1)
     {
      // Means it is trending Up
      ConfluenceTeam[46] = 1;

     }
   else
      if(Market_Structure_2(adx_indicator_handle_M30, PERIOD_M30) == 0)
        {
         // Means it is trending Down
         ConfluenceTeam[46] = 0;

        }
      else
        {
         // Means it is ranging/consolidating
         ConfluenceTeam[46] = -1;
        }

//   if(Market_Structure(adx_indicator_handle_D1) > 0)
//     {
//      // Means it is trending
//      ConfluenceTeam[22] = 1;
//      //ConfluenceTeamDefinition[3]="TRENDING...H1";
//
//     }
//   else
//     {
//      // Means it is ranging/consolidating
//      ConfluenceTeam[22] = -1;
//      //ConfluenceTeamDefinition[3]="CONSOLIDATING...H1";
//     }
//
// H4:
   if(Market_Structure(adx_indicator_handle_H4, PERIOD_H4) > 0)
     {
      // Means it is trending
      ConfluenceTeam[23] = 1;

     }
   else
     {
      // Means it is ranging/consolidating
      ConfluenceTeam[23] = -1;
     }

// Checks which direction it is trending
   if(Market_Structure_2(adx_indicator_handle_H4,PERIOD_H4) == 1)
     {
      // Means it is trending Up
      ConfluenceTeam[47] = 1;

     }
   else
      if(Market_Structure_2(adx_indicator_handle_H4, PERIOD_H4) == 0)
        {
         // Means it is trending Down
         ConfluenceTeam[47] = 0;

        }
      else
        {
         // Means it is ranging/consolidating
         ConfluenceTeam[47] = -1;
        }


   if(TrendLine_MarketStructure_PTL(indicator_handlePTL_2_H4) == 1)
     {
      //Print("TREND-Down...H4");
      ConfluenceTeam[12] = 0;
      ConfluenceTeamDefinition[12] = "TREND-DOWN...H4";
     }
   else
      if(TrendLine_MarketStructure_PTL(indicator_handlePTL_2_H4) == 0)
        {
         //Print("TREND-UP...H4");
         ConfluenceTeam[12] = 1;
         ConfluenceTeamDefinition[12] = "TREND-UP...H4";
        }
      else
        {
         ConfluenceTeam[12] = -1;
         ConfluenceTeamDefinition[12] = "NO-TREND";
        }

   if(TrendLine_MarketStructure_PTL(indicator_handlePTL_2_D1) == 1)
     {
      //Print("TREND-Down...H4");
      ConfluenceTeam[24] = 0;
      //ConfluenceTeamDefinition[12] = "TREND-DOWN...H4";
     }
   else
      if(TrendLine_MarketStructure_PTL(indicator_handlePTL_2_D1) == 0)
        {
         //Print("TREND-UP...H4");
         ConfluenceTeam[24] = 1;
         //ConfluenceTeamDefinition[12] = "TREND-UP...H4";
        }
      else
        {
         ConfluenceTeam[24] = -1;
         //ConfluenceTeamDefinition[12] = "NO-TREND";
        }

// TRENDLINE MARKET STRUCTURE:
   TrendLine_MarketStructure();


  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TrendLine_MarketStructure()
  {
// Trendline Status:

   Print("From trendlineMarket structure here: " + rates[1].close);
   if(Trending_Angle(indicator_Trending_Angle_M5_1,PERIOD_M5,rates) == 1)
     {
      ConfluenceTeam[32] = 1;
     }
   else
      if(Trending_Angle(indicator_Trending_Angle_M5_1,PERIOD_M5,rates) == 0)
        {
         ConfluenceTeam[32] = 0;

        }
      else
        {
         ConfluenceTeam[32] = -1;
        }

   if(Trending_Angle(indicator_Trending_Angle_H1_1,PERIOD_H1,rates) == 1)
     {
      ConfluenceTeam[41] = 1;
     }
   else
      if(Trending_Angle(indicator_Trending_Angle_H1_1,PERIOD_H1,rates) == 0)
        {
         ConfluenceTeam[41] = 0;

        }
      else
        {
         ConfluenceTeam[41] = -1;
        }

   if(Trending_Angle(indicator_Trending_Angle_H4_1,PERIOD_H4,rates) == 1)
     {
      ConfluenceTeam[42] = 1;
     }
   else
      if(Trending_Angle(indicator_Trending_Angle_H4_1,PERIOD_H4,rates) == 0)
        {
         ConfluenceTeam[42] = 0;

        }
      else
        {
         ConfluenceTeam[42] = -1;
        }

// Break of trendline structure on D1 Trendlines:
   if(BreakStructureTrendline(indicator_Trending_Angle_D1_1,PERIOD_D1,rates) == 1)
     {
      ConfluenceTeam[33] = 1;
     }
   else
      if(BreakStructureTrendline(indicator_Trending_Angle_D1_1,PERIOD_D1,rates) == 0)
        {
         ConfluenceTeam[33] = 0;
        }
      else
        {
         ConfluenceTeam[33] = -1;
        }

// Break of trendline structure on H4 Trendlines:
   if(BreakStructureTrendline(indicator_Trending_Angle_H4_1,PERIOD_H4,rates) == 1)
     {
      ConfluenceTeam[34] = 1;
     }
   else
      if(BreakStructureTrendline(indicator_Trending_Angle_H4_1,PERIOD_H4,rates) == 0)
        {
         ConfluenceTeam[34] = 0;
        }
      else
        {
         ConfluenceTeam[34] = -1;
        }

// Break of trendline structure on H1 Trendlines:
   if(BreakStructureTrendline(indicator_Trending_Angle_H1_1,PERIOD_H1,rates) == 1)
     {
      ConfluenceTeam[35] = 1;
     }
   else
      if(BreakStructureTrendline(indicator_Trending_Angle_H1_1,PERIOD_H1,rates) == 0)
        {
         ConfluenceTeam[35] = 0;
        }
      else
        {
         ConfluenceTeam[35] = -1;
        }

// TrendLine Area Check: if price closed near the trendline or not
   if(Trendline_AreaCheck(indicator_Trending_Angle_D1_1,PERIOD_D1,rates,170) == 1)
     {
      // Found on Support
      ConfluenceTeam[36] = 1;
     }
   else
      if(Trendline_AreaCheck(indicator_Trending_Angle_D1_1,PERIOD_D1,rates,170) == 0)
        {
         // Found on Resistance
         ConfluenceTeam[36] = 0;
        }
      else
        {
         ConfluenceTeam[36] = -1;
        }
// TrendLine Area Check: H4
   if(Trendline_AreaCheck(indicator_Trending_Angle_H4_1,PERIOD_H4,rates,90) == 1)
     {
      // Found on Support
      ConfluenceTeam[37] = 1;
     }
   else
      if(Trendline_AreaCheck(indicator_Trending_Angle_H4_1,PERIOD_H4,rates,90) == 0)
        {
         // Found on Resistance
         ConfluenceTeam[37] = 0;
        }
      else
        {
         ConfluenceTeam[37] = -1;
        }

// TrendLine Area Check: H1
   if(Trendline_AreaCheck(indicator_Trending_Angle_H1_1,PERIOD_H1,rates,50) == 1)
     {
      // Found on Support
      ConfluenceTeam[38] = 1;
     }
   else
      if(Trendline_AreaCheck(indicator_Trending_Angle_H1_1,PERIOD_H1,rates,50) == 0)
        {
         // Found on Resistance
         ConfluenceTeam[38] = 0;
        }
      else
        {
         ConfluenceTeam[38] = -1;
        }



  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  MA_Crossing_Work()
  {
// Check if it has crossed up or not, depending on the Period.
   if(ConfluenceTeam[0]==1)
     {
      ConfluenceTeamDefinition[0] = "MA_CROSS_M15 UP";
     }
   else
      if(ConfluenceTeam[0]==0)
        {
         ConfluenceTeamDefinition[0] = "MA_CROSS_M15 DOWN";
        }
      else
        {
         ConfluenceTeamDefinition[0] = "MA_CROSS_M15...----";
        }

   if(ConfluenceTeam[10]==1)
     {
      ConfluenceTeamDefinition[10] = "MA_CROSS_M15 UP";
     }
   else
      if(ConfluenceTeam[10]==0)
        {
         ConfluenceTeamDefinition[10] = "MA_CROSS_M15 DOWN";
        }
      else
        {
         ConfluenceTeamDefinition[10] = "MA_CROSS_M15...----";
        }


// Check if it has crossed up or not, depending on the Period.
   ConfluenceTeam[0] = MA_Cross(indicator_customMA_M5_1, indicator_customMA_M5_2);
   ConfluenceTeam[26] = MA_Cross(indicator_customMA_D1_1, indicator_customMA_D1_2);
   ConfluenceTeam[27] = MA_Cross(indicator_customMA_H4_1, indicator_customMA_H4_2);
   ConfluenceTeam[28] = MA_Cross(indicator_customMA_H1_1, indicator_customMA_H1_2);
   ConfluenceTeam[29] = MA_Cross(indicator_customMA_M30_1, indicator_customMA_M30_2);
   ConfluenceTeam[30] = MA_Cross(indicator_customMA_M15_1, indicator_customMA_M15_2);


//ConfluenceTeam[10] = MA_Cross(indicator_customMA_M15_1, indicator_customMA_M15_2);


  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Moving_AveragePrice_Action_Work(MqlRates &ratesCurr[])
  {


//     ************ ^^CONFLUNCE DEFINITION^^ ***********   //





// Check if price is above/below the MA !!!
   if(MA_PriceAction(indicator_customMA_H4_1, indicator_customMA_H4_2,PERIOD_H4) == 1)
     {
      ConfluenceTeam[2] = 1;
      ConfluenceTeamDefinition[2] = "MA_H4_UP";
     }
   else
     {
      ConfluenceTeam[2]=0;
      ConfluenceTeamDefinition[2] = "MA_H4_DOWN";
     }

   if(MA_PriceAction(indicator_customMA_H1_1, indicator_customMA_H1_2,PERIOD_H1) == 1)
     {
      ConfluenceTeam[8] = 1;
      ConfluenceTeamDefinition[8] = "MA_H1_UP";
     }
   else
     {
      ConfluenceTeam[8]=0;
      ConfluenceTeamDefinition[8] = "MA_H1_DOWN";
     }

   if(MA_PriceAction(indicator_customMA_M30_1, indicator_customMA_M30_2,PERIOD_M30) == 1)
     {
      ConfluenceTeam[9] = 1;
      ConfluenceTeamDefinition[9] = "MA_M30_UP";
     }
   else
     {
      ConfluenceTeam[9]=0;
      ConfluenceTeamDefinition[9] = "MA_M30_DOWN";
     }

// MA_PriceAction M5
   if(MA_PriceAction(indicator_customMA_M5_1, indicator_customMA_M5_2,PERIOD_M5) == 1)
     {
      ConfluenceTeam[31] = 1;
     }
   else
     {
      ConfluenceTeam[31] =0;

     }

   if(MovingAverage_Near_Price(indicator_customMA_H1_1, indicator_customMA_H1_2, PERIOD_H1,100) > 0)
     {
      ConfluenceTeam[14] = 1;
      ConfluenceTeamDefinition[16] = "MA_NEAR";
     }
   else
     {
      ConfluenceTeam[14] = -1;
      ConfluenceTeamDefinition[16] = "NO  MA_NEAR";
     }




   if(MovingAverage_Near_Price(indicator_customMA_M5_1, indicator_customMA_M5_2, PERIOD_M5,35) > 0)
     {
      ConfluenceTeam[15] = 1;
      //ConfluenceTeamDefinition[16] = "MA_NEAR";
     }
   else
     {
      ConfluenceTeam[15] = -1;
      //ConfluenceTeamDefinition[16] = "NO  MA_NEAR";
     }
//Comment("MACross: "+MA_Cross(indicator_customMA_M5_1, indicator_customMA_M5_2));
//Comment("Status:   "+MovingAverage_Near_Price(indicator_customMA_H1_1, indicator_customMA_H1_2, PERIOD_H1));

// Checking if the current candle rates[1].close is the first to close above/below the corresponding MA
   if(MA_PriceActionFirstCandle(indicator_customMA_H4_1,indicator_customMA_H4_2,PERIOD_H4) == 1)
     {
      // First candle in H4 closing above MA price
      ConfluenceTeam[39] = 1;
     }
   else
      if(MA_PriceActionFirstCandle(indicator_customMA_H4_1,indicator_customMA_H4_2,PERIOD_H4) == 0)
        {
         // First candle in H4 closing below MA price
         ConfluenceTeam[39] = 0;
        }
      else
        {
         ConfluenceTeam[39] = -1;
        }

   if(MA_PriceActionFirstCandle(indicator_customMA_H1_1,indicator_customMA_H1_2,PERIOD_H1) == 1)
     {
      // First candle in H1 closing above MA price
      ConfluenceTeam[40] = 1;
     }
   else
      if(MA_PriceActionFirstCandle(indicator_customMA_H1_1,indicator_customMA_H1_2,PERIOD_H1) == 0)
        {
         // First candle in H1 closing below MA price
         ConfluenceTeam[40] = 0;
        }
      else
        {
         ConfluenceTeam[40] = -1;
        }

   if(MA_PriceActionCandleRetest(indicator_customMA_H1_1,indicator_customMA_H1_2,PERIOD_H1) == 1)
     {
      ConfluenceTeam[43] = 1;
     }
   else
      if(MA_PriceActionCandleRetest(indicator_customMA_H1_1,indicator_customMA_H1_2,PERIOD_H1) == 0)
        {
         ConfluenceTeam[43] = 0;
        }
      else
        {
         ConfluenceTeam[43] = -1;
        }

// H4
   if(MA_PriceActionCandleRetest(indicator_customMA_H4_1,indicator_customMA_H4_2,PERIOD_H4) == 1)
     {
      ConfluenceTeam[44] = 1;
     }
   else
      if(MA_PriceActionCandleRetest(indicator_customMA_H4_1,indicator_customMA_H4_2,PERIOD_H4) == 0)
        {
         ConfluenceTeam[44] = 0;
        }
      else
        {
         ConfluenceTeam[44] = -1;
        }


  }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Price_Value(ENUM_TIMEFRAMES period)
  {
   MqlRates CurrRates[];
   ArraySetAsSeries(CurrRates,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),CurrRates);

   return CurrRates[1].close;
  }





// Used by Strategy #3 for alternating trades between sell and buy.
bool BUY_TRADE = true;
bool SELL_TRADE = false;
int doubArray[5][5];

double Ask, Bid;
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
// Generating random values
//int num = 1 + 10*MathRand()/32768; // 1-10


// =======================  MA_Crossing ======================= //
   MA_Crossing_Work();

// Update the EA at every period below:
   if(CheckNewBar(PERIOD_M5) != 1)
      return;

   ArraySetAsSeries(rates,true);
   CopyRates(Symbol(),PERIOD_M5,0,Bars(Symbol(),PERIOD_M5),rates);
   RewardSystem(rates);



   Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   ArraySetAsSeries(rates,true);
   CopyRates(Symbol(),PERIOD_M5,0,Bars(Symbol(),PERIOD_M5),rates);

// ======================= Support && Resistance Zones Work ======================= //

   double Resi_Zone_M5 = Support_Resistance_Zones_Sell(indicator_handleSupRes_M5,0);
   double Supp_Zone_M5 = Support_Resistance_Zones_Buy(indicator_handleSupRes_M5,0);

   Support_Resistance_Work(rates);

// ======================= CandleStickTypes And Patterns ======================= //
   CandleStick_Patterns();


//            Dangerous Stuff down there HAhahahhahahaa >>>

//   for(int colEntry = 0; colEntry < 21; colEntry++)
//     {
//      //colEntry = 0;
//      if(colEntry == 6)
//        {
//         colEntry = 0;
//        }
//      Print("Same Same Same Same Same");
//
//
//     }
//      <<< Dangerous Stuff Up there HAhahahhahahaa



//Comment(" Conf[0]:  "+ConfluenceTeam[0]+"\n"
//        +" Conf[1]:  "+ConfluenceTeam[1]+"\n"
//        + " Conf[2]:  "+ConfluenceTeam[2]+"\n"
//        + " Conf[3]:  "+ConfluenceTeam[3]+"\n"
//        + " Conf[4]:  "+ConfluenceTeam[4]+"\n"
//        + " Conf[5]:  "+ConfluenceTeam[5]+"\n"
//        +" Conf[6]:  "+ConfluenceTeam[6]+"\n"
//        + " Conf[7]:  "+ConfluenceTeam[7]+"\n"
//        + " Conf[8]:  "+ConfluenceTeam[8]+"\n"
//        + " Conf[9]:  "+ConfluenceTeam[9]+"\n"
//        + " Conf[10]:  "+ConfluenceTeam[10]+"\n"
//        +" Conf[11]:  "+ConfluenceTeam[11]+"\n"
//        + " Conf[12]:  "+ConfluenceTeam[12]+"\n"
//        + " Conf[13]:  "+ConfluenceTeam[13]+"\n"
//        + " Conf[14]:  "+ConfluenceTeam[14]+"\n"
//        + " Conf[15]:  "+ConfluenceTeam[15]+"\n"
//       );



// =======================  Market Structure Work (Trend Pullback, Range, Retracements) ======================= //

   Market_Structure_Work();

   int TradingZone = Trading_Zone(ConfluenceTeam[3],ConfluenceTeam[48],ConfluenceTeam[45],ConfluenceTeam[46],ConfluenceTeam[23],ConfluenceTeam[47]);





//   for(int i=PositionsTotal(); i>=0; i--)
//     {
//      if(Symbol()==PositionGetSymbol(i))
//        {
//         // get ticket number
//         ulong PositionTicket = PositionGetInteger(POSITION_TICKET);
//
//         //// get current stop loss
//         //double currentStopLoss = PositionGetDouble(POSITION_SL);
//
//         // Modify Stpo loss
//         //trade.PositionClose(PositionTicket);
//
//         //Print("TRADE/RESULT: ");
//         //trade.PrintResult();
//         //trade.
//        }
//     }

// ======================= Moving Average Price Action ======================= //



// Check if price is below/upper the MA price, depending on the Period.
   Moving_AveragePrice_Action_Work(rates);



//ArrayFill(doubArray,0,3,52);

// ======================= Entry Strategies ======================= //
   create_Default_Entry_Confluences();


//Comment("MN1_Pivot_Area: "+ Default_Entry_Confluences[0]
//        +"\nD1_PivotsArea: "+Default_Entry_Confluences[2]);
   Comment("Trending Angle_M5: SLOW ONE: "+ConfluenceTeam[32]);

//WriteData("testingFiles",25,Default_Entry_Confluences);
// ======================= Entry Strategy ##1 ======================= //

//    This strategy detects if price's body is formed on a pivot price and if it forms at the same a pattern in order to make
//    a trade.

// GOing up trade is 0. Going down trade is 1.
//if(PositionSelect(Symbol())==true)
//  {
//   positionType = PositionGetInteger(POSITION_TYPE);
//  }
//Print("PositionGetInteger(POSITION_TYPE): "+PositionGetInteger(POSITION_TYPE) +" PositionType: "+positionType);

//PivotPricesContainer(indicator_handlePivot_H4_vis_to_M5,PERIOD_M5);
//PivotPricesContainer(indicator_handlePivot_D1_vis_to_M5,PERIOD_M5);
//PivotPricesContainer(indicator_handlePivot_MN1_vis_to_M5,PERIOD_M5);
//int strategyNum1 = Strategy_Num_1(rates,PivotBufferPrices,Patterns_Down(indicator_handlePatterns_M5,1),Patterns_Up(indicator_handlePatterns_M5,1));



//Comment(" Happened:  "+strategyNum1);
// Situation 1: going down and then cancel. Trade up
//   if(positionType == 1 && strategyNum1 == 1)
//     {
//      CancelOrder();
//      if(PositionSelect(Symbol())==false)
//        {
//         trade.Buy(1,Symbol(),Ask,Supp_Zone_M5,(Ask + 2*MathAbs(Ask - Supp_Zone_M5)));
//        }
//     }
//// Situation 1: going up and then cancel. Trade down
//   if(positionType == 0 && strategyNum1 == 0)
//     {
//      CancelOrder();
//      if(PositionSelect(Symbol())==false)
//        {
//         trade.Sell(1,Symbol(),Bid,Resi_Zone_M5,(Bid - 2*MathAbs(Bid - Resi_Zone_M5)));
//        }
//     }






// ======================= Entry Strategy ##2 ======================= //

//    This Strategy uses H4 Patterns, PTL_H4, Price closing super close to MA on H1, ADX for detecting range, and it executes only when in Supp-Demand Zone of H1;
//int strategyNum2 = Strategy_Num_2(ConfluenceTeam[13],ConfluenceTeam[5],ConfluenceTeam[14],ConfluenceTeam[6],ConfluenceTeam[3],ConfluenceTeam[12], ConfluenceTeam[7]);
//Comment("strag #2: "+ strategyNum2+"\n"
//        +"in Supp-Dem zone: "+ConfluenceTeam[13]+"\n"
//        +"PivotArea: "+ConfluenceTeam[5]+"\n"
//        +"MaNearPrice: "+ConfluenceTeam[14]+"\n"
//        +"Patterns: "+ConfluenceTeam[6]+"\n"
//        +"Patterns_H1: "+ConfluenceTeam[7]+"\n"
//        +"ADX: "+ConfluenceTeam[3]+"\n"
//        +"PTL_H4: "+ConfluenceTeam[12]+"\n"
//       );

// Situation 1:  Trade up

//   if(strategyNum2 == 1)
//     {
//
//      if(PositionSelect(Symbol())==false)
//        {
//         trade.Buy(1,Symbol(),Ask,(Ask - 3*MathAbs(Ask - Supp_Zone_M5)),(Ask + 6*MathAbs(Ask - Supp_Zone_M5)));
//        }
//     }
//// Situation 1: Trade down
//   if(strategyNum2 == 0)
//     {
//
//      if(PositionSelect(Symbol())==false)
//        {
//         trade.Sell(1,Symbol(),Bid,(Bid + 3*MathAbs(Bid - Resi_Zone_M5)),(Bid - 6*MathAbs(Bid - Resi_Zone_M5)));
//        }
//     }





// ======================= Entry Strategy ##3 ======================= //

// This strategy uses simple decisions like MA cross on M5, PATTERNS on M5 and Price closing super near to MA.
// Its sole purpose is to help us define various strategies by being a reference. THis is very basic strategy   //

//Print("sIZE OF 2D array: "+ArraySize(doubArray));
//for(int i =0; i<5; i++)
//  {
//   for(int j=0; j<2;j++)
//     {
//      Print("doubArray[0][1]:  "+doubArray[i][j]);
//     }
//  }
//if(doubArray[0][1] == doubArray[3][1])
//  {
//   Print("They are equal");
//  }
//if(doubArray[0][1] == doubArray[0][0])
//  {
//   Print("They are equal: "+doubArray[0][0]);
//  }





   int strategyNum3 = Strategy_Num_3(ConfluenceTeam[1], ConfluenceTeam[0],ConfluenceTeam[16],ConfluenceTeam[17],ConfluenceTeam[31]);


//             Next Big Problems to solve: Check if the checkSimilarity works well thorugh comments/printing. Does it really check if two strategies are the same ????? //
//             Next Big Problems to solve: Is the reward system array really connected to the row numbers ??? Check please. After that, we can let it go wild. Woooooh



// Situation 1: Trade up
//   if(strategyNum3 == 1)
//     {
//      //CancelOrder();
//
//
//
//      //VolumeValue_Buy[counter_OrderInfo_Buy] = Buying_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),
//      //      Buying_SL(Supp_Zone_M5,0,0,0) // Volume
//      //      ,Ask);
//      //orderNumber_Status_Buy[counter_OrderInfo_Buy] = Ask;
//      ////Print("Ask: "+ orderNumber_Status_Buy[counter_OrderInfo_Buy]);
//      //Price_TP_Buy[counter_OrderInfo_Buy] =  Buying_TP(PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,0),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,1), // Take Profit
//      //                                       PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,2),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,3)         // Take Profit
//      //                                       , Buying_SL(Supp_Zone_M5,0,0,0)
//      //                                       ,Ask);
//      //Price_SL_Buy[counter_OrderInfo_Buy] = Buying_SL((Ask - 1*MathAbs(Ask - Supp_Zone_M5)),0,0,0);
//      //orderNumber_Status_Buy[counter_OrderInfo_Buy] = trans.order;
//
//      // Price Line
//      //ObjectCreate(0,DoubleToString(orderNumber_Status_Buy[counter_OrderInfo_Buy]),OBJ_HLINE,0,0,orderNumber_Status_Buy[counter_OrderInfo_Buy]);
//      //ObjectSetInteger(0,DoubleToString(orderNumber_Status_Buy[counter_OrderInfo_Buy]),OBJPROP_COLOR,clrGray);
//      //ObjectSetInteger(0,DoubleToString(orderNumber_Status_Buy[counter_OrderInfo_Buy]),OBJPROP_STYLE,STYLE_DASHDOT);
//      //// Take Profit Line
//      //ObjectCreate(0,DoubleToString(Price_TP_Buy[counter_OrderInfo_Buy]),OBJ_HLINE,0,0,Price_TP_Buy[counter_OrderInfo_Buy]);
//      //ObjectSetInteger(0,DoubleToString(Price_TP_Buy[counter_OrderInfo_Buy]),OBJPROP_COLOR,clrGreen);
//      //ObjectSetInteger(0,DoubleToString(Price_TP_Buy[counter_OrderInfo_Buy]),OBJPROP_STYLE,STYLE_DASHDOT);
//      //// Stop loss line
//      //ObjectCreate(0,DoubleToString(Price_SL_Buy[counter_OrderInfo_Buy]),OBJ_HLINE,0,0, Price_SL_Buy[counter_OrderInfo_Buy]);
//      //ObjectSetInteger(0,DoubleToString(Price_TP_Buy[counter_OrderInfo_Buy]),OBJPROP_COLOR,clrRed);
//      //ObjectSetInteger(0, DoubleToString(Price_SL_Buy[counter_OrderInfo_Buy]),OBJPROP_STYLE,STYLE_DASHDOT);
//
//      //++counter_OrderInfo_Buy;
//
//      //ObjectSetInteger(0,name,OBJPROP_COLOR,Level_00_Color);
//
//      //if(PositionSelect(Symbol())==false)
//      //  {
//      trade.Buy(Buying_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),
//                              Buying_SL(Supp_Zone_M5,0,0,0) // Volume
//                              ,Ask), // Volume
//                NULL,Ask,
//                Buying_SL((Ask - 1*MathAbs(Ask - Supp_Zone_M5)),0,0,0),                   // Stop Loss
//                Buying_TP(PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,0),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,1), // Take Profit
//                          PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,2),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,3)         // Take Profit
//                          , Buying_SL(Supp_Zone_M5,0,0,0)
//                          ,Ask),"Entry #3");
//
//      //trade.Buy(1,Symbol(),Ask,(Ask - 1*MathAbs(Ask - Supp_Zone_M5)),(Ask + 2*MathAbs(Ask - Supp_Zone_M5)));
//      BUY_TRADE = false;
//      SELL_TRADE = true;
//      //}
//     }
////else
//// Situation 1: Trade down
//   if(strategyNum3 == 0)
//     {
//      //CancelOrder();
//      //VolumeValue_Sell[counter_OrderInfo_Sell] = Selling_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),Selling_SL(Resi_Zone_M5,0,0,0), // Volume to trade with
//      //      Bid);
//      //orderNumber_Status_Sell[counter_OrderInfo_Sell] = Bid;
//      //Price_TP_Sell[counter_OrderInfo_Sell] =  Selling_TP(PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,0),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,4),
//      //      PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,5),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,5), // Take Profit
//      //      Selling_SL(Resi_Zone_M5,0,0,0)
//      //      ,Bid);
//      //Price_SL_Sell[counter_OrderInfo_Sell] = Selling_SL((Bid + 1*MathAbs(Resi_Zone_M5-Bid)),0,0,0);
//      //orderNumber_Status_Sell[counter_OrderInfo_Sell] = trans.order;
//
//      // Price Line
//      //ObjectCreate(0,DoubleToString(orderNumber_Status_Sell[counter_OrderInfo_Sell]),OBJ_HLINE,0,0,orderNumber_Status_Sell[counter_OrderInfo_Sell]);
//      //ObjectSetInteger(0,DoubleToString(orderNumber_Status_Sell[counter_OrderInfo_Sell]),OBJPROP_COLOR,clrGray);
//      //ObjectSetInteger(0,DoubleToString(orderNumber_Status_Sell[counter_OrderInfo_Sell]),OBJPROP_STYLE,STYLE_DASHDOT);
//      //// Take Profit Line
//      //ObjectCreate(0,DoubleToString(Price_TP_Sell[counter_OrderInfo_Sell]),OBJ_HLINE,0,0, Price_TP_Sell[counter_OrderInfo_Sell]);
//      //ObjectSetInteger(0,DoubleToString(Price_TP_Sell[counter_OrderInfo_Sell]),OBJPROP_COLOR,clrRed);
//      //ObjectSetInteger(0,DoubleToString(Price_TP_Sell[counter_OrderInfo_Sell]),OBJPROP_STYLE,STYLE_DASHDOT);
//      //// Stop loss line
//      //ObjectCreate(0,DoubleToString(Price_SL_Sell[counter_OrderInfo_Sell]),OBJ_HLINE,0,0, Price_SL_Sell[counter_OrderInfo_Sell]);
//      //ObjectSetInteger(0,DoubleToString(Price_TP_Sell[counter_OrderInfo_Sell]),OBJPROP_COLOR,clrRed);
//      //ObjectSetInteger(0, DoubleToString(Price_SL_Sell[counter_OrderInfo_Sell]),OBJPROP_STYLE,STYLE_DASHDOT);
//
//      //++counter_OrderInfo_Sell;
//
//      //if(PositionSelect(Symbol())==false)
//      //  {
//      trade.Sell(Selling_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),Selling_SL(Resi_Zone_M5,0,0,0), // Volume to trade with
//                                Bid), NULL,Bid,
//                 Selling_SL((Bid + 1*MathAbs(Resi_Zone_M5-Bid)),0,0,0),           // Stop Loss
//                 Selling_TP(PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,0),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,4),
//                            PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,5),PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,5), // Take Profit
//                            Selling_SL(Resi_Zone_M5,0,0,0)
//                            ,Bid),"Entry #3");
//
//
//      //trade.Sell(1,Symbol(),Bid,(Bid + 1*MathAbs(Resi_Zone_M5-Bid)),(Bid - 2*MathAbs(Bid - Resi_Zone_M5)));
//      SELL_TRADE = false;
//      BUY_TRADE = true;
//      //}
//     }


//Strategies_Inventories(strategyNum3);

// For distributing rewards for each strategy out there.



//   fileWriting("BuyCategoryInvetory.bin","BuyCategoryInvetory.txt",Default_Entry_Confluences,BuyStrategiesCategory);
//   fileWriting_Reward("Reward_SystemBuy.bin","Reward_SystemBuy.txt",RewardSystem_Buy);
//
//   fileWriting("SellCategoryInvetory.bin","SellCategoryInvetory.txt",Default_Entry_Confluences,SellStrategiesCategory);
//   fileWriting_Reward("Reward_SystemSell.bin","Reward_SystemSell.txt",RewardSystem_Sell);


//   if(strategyNum3 == 1)
//     {
//      //fileWriting("fileCreated.bin","hello chris",Default_Entry_Confluences);
//      fileWriting("BuyCategoryInvetory.bin","BuyCategoryInvetory.txt",Default_Entry_Confluences,BuyStrategiesCategory);
//      fileWriting_Reward("Reward_SystemBuy.bin","Reward_SystemBuy.txt",RewardSystem_Buy);
//      //fileReading("BuyCategoryInvetory.bin");
//     }
////else
//   if(strategyNum3 == 0)
//     {
//      //fileWriting("fileCreated.bin","hello chris",Default_Entry_Confluences);
//      fileWriting("SellCategoryInvetory.bin","SellCategoryInvetory.txt",Default_Entry_Confluences,SellStrategiesCategory);
//      fileWriting_Reward("Reward_SystemSell.bin","Reward_SystemSell.txt",RewardSystem_Sell);
//      //fileReading("BuyCategoryInvetory.bin");
//     }





// ======================= Entry Strategy ##4 ======================= //

// This straetgy uses the Pivot Buffer prices in order to trade each time the price gets very near it.
   bool strategyNum4 = Strategy_Num_4(rates,PERIOD_D1,ConfluenceTeam[3]);
   if(strategyNum4 == true)
     {
      // TRADE:

      // Buy :
      //trade.Buy(Buying_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),
      //                        Buying_SL(Supp_Zone_M5,Strategy_Num_4_SL_Possibilities("Buy",rates,Ask),0,0) // Volume
      //                        ,Ask), // Volume
      //          NULL,Ask,
      //          Buying_SL(Supp_Zone_M5,Strategy_Num_4_SL_Possibilities("Buy",rates,Ask),0,0),                   // Stop Loss
      //          Buying_TP(Strategy_Num_4_TP_Selection("Buy",rates,Ask),0,0,0        // Take Profit
      //                    , Buying_SL(Supp_Zone_M5,Strategy_Num_4_SL_Possibilities("Buy",rates,Ask),0,0)
      //                    ,Ask),"Entry #3");
      //trade.Buy(Buying_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE), // Volume
      //                        (Ask - 200*_Point)
      //                        ,Ask)
      //          ,Symbol(),Ask,(Ask - 200*_Point),(Ask + 520*_Point));

      // Sell :
      //trade.Sell(Selling_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),Selling_SL(Resi_Zone_M5,Strategy_Num_4_SL_Possibilities("Sell",rates,Bid),0,0), // Volume to trade with
      //                          Bid), NULL,Bid,
      //           Selling_SL(Resi_Zone_M5,Strategy_Num_4_SL_Possibilities("Sell",rates,Bid),0,0),           // Stop Loss
      //           Selling_TP(Strategy_Num_4_TP_Selection("Sell",rates,Bid),0,0,0 // Take Profit
      //                      , Selling_SL(Resi_Zone_M5,Strategy_Num_4_SL_Possibilities("Sell",rates,Bid),0,0)
      //                      ,Bid),"Entry #3");
      //trade.Sell(Selling_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),(Bid + 200*_Point), // Volume to trade with
      //                          Bid)
      //           ,Symbol(),Bid,(Bid + 200*_Point),(Bid - 520*_Point));

      TRADE_OR_NOT = false;
     }


   if(PositionsTotal() == 0)
     {
      TRADE_OR_NOT = true;
     }
//Comment("counter_OrderInfo_Sell: "+counter_OrderInfo_Sell
//        +"\ncounter_OrderInfo_Buy: "+counter_OrderInfo_Buy
//        +"\nrowNumberPosition_SellCounter: "+rowNumberPosition_SellCounter
//        +"\nrowNumberPosition_BuyCounter: "+rowNumberPosition_BuyCounter);

//int priceNearTrendline_D1, int priceNearTrendline_H4, int priceNearTrendline_H1,
//                   int trendLineBreakStructure_D1, int trendLineBreakStructure_H4, int trendLineBreakStructure_H1,
//                   int pivotAreaCheck_D1, int pivotAreaCheck_H4, int pivotAreaCheck_MN1,
//                   int MA_PriceActionFirstCandle_H4, int MA_PriceActionFirstCandle_H1,
//                   int MA_PriceActionCandleRetest_H4, int MA_PriceActionCandleRetest_H1,
//                   int trendLine_H4, int trendlINE_H1,
//                   int patterns_M5, int MA_PriceAction_M5
//                   int tradeZone



// ======================= Entry Strategy ##5 ======================= //



   int strategyNum5 = Strategy_Num_5(ConfluenceTeam[36],ConfluenceTeam[37],ConfluenceTeam[38],
                                     ConfluenceTeam[33],ConfluenceTeam[34],ConfluenceTeam[35],
                                     ConfluenceTeam[14],ConfluenceTeam[15],ConfluenceTeam[13],
                                     ConfluenceTeam[39],ConfluenceTeam[40],
                                     ConfluenceTeam[44],ConfluenceTeam[43],
                                     ConfluenceTeam[42],ConfluenceTeam[41],
                                     ConfluenceTeam[1],ConfluenceTeam[31],TradingZone
                                    );

   int realCurrent_SL = PositionGetDouble(POSITION_SL);
   int randNumber = 3 + 3*MathRand()/32768; // 3-5



//   if(strategyNum5 == 1)
//     {
//      if(PositionSelect(Symbol())==false)
//        {
//
//         trade.Buy(Buying_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE), // Volume
//                                 Supp_Zone_M5
//                                 ,Ask),Symbol(),Ask,Supp_Zone_M5,(Ask + randNumber*MathAbs(Ask - Supp_Zone_M5)),"StraT_5");
//        }
//
//     }
//   else
//      if(strategyNum5 == 0)
//        {
//         if(PositionSelect(Symbol())==false)
//           {
//            trade.Sell(Selling_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),(Resi_Zone_M5), // Volume to trade with
//                                      Bid)
//                       ,Symbol(),Bid,Resi_Zone_M5,(Bid - randNumber*MathAbs(Bid - Resi_Zone_M5)),"StraT_5");
//
//           }
//
//        }

//Comment("priceNearTrendline_D1,"+ConfluenceTeam[36]
//        +"\n int priceNearTrendline_H4: "+ConfluenceTeam[37]
//        +"\n int priceNearTrendline_H1: "+ConfluenceTeam[38]
//        +"\nint trendLineBreakStructure_D1: "+ConfluenceTeam[33]
//        +"\nint trendLineBreakStructure_H4: "+ConfluenceTeam[34]
//        +"\nint trendLineBreakStructure_H1: "+ConfluenceTeam[35]
//        +"\nMA retest_h1: "+ConfluenceTeam[43]
//        +"\nMA retest_h4: "+ConfluenceTeam[44]
//        +"\n price + 150*_Point AUDUSD = "+(rates[1].close + 150*_Point)
//        +"\nrandNumber: "+randNumber
//        +"\nCurrSl: "+PositionGetDouble(POSITION_SL)
//        +"\nStrategyNum5: "+strategyNum5);





   Deal_EntryIn = false;




// ======================= Entry Strategy ##0 ======================= //
   int strategyNum0 = Strategy_Num_0(ConfluenceTeam[28],ConfluenceTeam[0],ConfluenceTeam[15],TradingZone);

   Comment("MA_Crossover_H1: "+ConfluenceTeam[28]
           +"MA_Crossover_M5: "+ConfluenceTeam[0]
           +"\nTradingZone: "+TradingZone
           +"\nADX_H1: "+ConfluenceTeam[3]
           +"\nADX_H4: "+ConfluenceTeam[23]
           +"\nDI_M30: "+ConfluenceTeam[46]
           +"\nDI_H4: "+ConfluenceTeam[47]);

   if(strategyNum0 == 1)
     {
      trade.Buy(Buying_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE), // Volume
                              Supp_Zone_M5
                              ,Ask),Symbol(),Ask,Supp_Zone_M5,(Ask + randNumber*MathAbs(Ask - Supp_Zone_M5)),"StraT_0");
     }
   else
      if(strategyNum0 == 0)
        {
         trade.Sell(Selling_Volume(0.01*AccountInfoDouble(ACCOUNT_BALANCE),(Resi_Zone_M5), // Volume to trade with
                                   Bid)
                    ,Symbol(),Bid,Resi_Zone_M5,(Bid - randNumber*MathAbs(Bid - Resi_Zone_M5)),"StraT_0");
        }



   if(PositionSelect(Symbol())==true && PositionGetInteger(POSITION_TYPE) == 1)
     {
      changeSLSelling(PositionGetDouble(POSITION_SL),Support_and_Resistance_Prices(indicator_handleSupRes_H1,1,0));
     }
   if(PositionSelect(Symbol())==true && PositionGetInteger(POSITION_TYPE) == 0)
     {
      changeSLBuying(PositionGetDouble(POSITION_SL), Support_and_Resistance_Prices(indicator_handleSupRes_H1,1,1));
     }

//  ============================== Possibe CHAIN OF DECISION  ============================== //

//if(ConfluenceTeam[4] != -1 || ConfluenceTeam[5] != -1)
//  {
//   // Market Structure Trend/Range. Needs to be a trend.
//   if(ConfluenceTeam[3] == 1)
//     {
//      // Buy Confluence: Market Structure using PTL(2) on H4
//      if(ConfluenceTeam[12] == 1)
//        {
//         // Buy Confluence: PatternS using H4 or D1
//         if(ConfluenceTeam[6] == 1 || ConfluenceTeam[7] == 1)
//           {
//            // Buy Confluence: MA Price Action on H1 or M30
//            if(ConfluenceTeam[8] ==1 || ConfluenceTeam[9] == 1)
//              {
//               // Buy Confluence: MA Crossover on M15 or M5
//               if((ConfluenceTeam[10] ==1 || ConfluenceTeam[0] == 1) && (ConfluenceTeam[1] == 1 || ConfluenceTeam[11] == 1))
//                 {
//                  if(PositionSelect(Symbol())==false)
//                    {
//                     //trade.Buy(1,Symbol(),Ask,Supp_Zone_M5,(Ask + 2*MathAbs(Ask - Supp_Zone_M5)));
//                    }
//                 }
//              }
//           }
//        }
//      // Sell Confluence: Market Structure using PTL(2) on H4
//      if(ConfluenceTeam[12] == 0)
//        {
//         // Sell Confluence: Patterns using H4 or D1
//         if(ConfluenceTeam[6] == 0 || ConfluenceTeam[7] == 0)
//           {
//            // Sell Confluence: Market Structure using MA Price Action on H1 or M30
//            if(ConfluenceTeam[8] == 0 || ConfluenceTeam[9] == 0)
//              {
//               // Sell Confluence: MA Crossover on M15 or M5
//               if((ConfluenceTeam[10] == 0 || ConfluenceTeam[0] == 0) && (ConfluenceTeam[1] == 0 || ConfluenceTeam[11] == 0))
//                 {
//                  if(PositionSelect(Symbol())==false)
//                    {
//                     //trade.Sell(1,Symbol(),Bid,Resi_Zone_M5,(Bid - 2*MathAbs(Bid - Resi_Zone_M5)));
//                    }
//                 }
//              }
//           }
//        }
//     }
//  }



//   Comment(" Conf[0]:  "+ConfluenceTeamDefinition[0]+"\n"
//           +" Conf[1]:  "+ConfluenceTeamDefinition[1]+"\n"
//           + " Conf[2]:  "+ConfluenceTeamDefinition[2]+"\n"
//           + " Conf[3]:  "+ConfluenceTeamDefinition[3]+"\n"
//
//           +" Conf[6]:  "+ConfluenceTeamDefinition[6]+"\n"
//           + " Conf[7]:  "+ConfluenceTeamDefinition[7]+"\n"
//           + " Conf[8]:  "+ConfluenceTeamDefinition[8]+"\n"
//           + " Conf[9]:  "+ConfluenceTeamDefinition[9]+"\n"
//           + " Conf[10]:  "+ConfluenceTeamDefinition[10]+"\n"
//           +" Conf[11]:  "+ConfluenceTeamDefinition[11]+"\n"
//           + " Conf[12]:  "+ConfluenceTeamDefinition[12]+"\n"
//           + " Conf[13]:  "+ConfluenceTeamDefinition[13]+"\n"
//           + " Conf[14]:  "+ConfluenceTeamDefinition[14]+"\n"
//           + " Conf[15]:  "+ConfluenceTeamDefinition[15]+"\n"
//           +"CONF[5]:     "+ConfluenceTeam[5]
//           +" Conf[6]:  "+ConfluenceTeam[6]+"\n"
//           + " Conf[7]:  "+ConfluenceTeam[7]+"\n"
//          );
   positionType = -1;

// This is to prevent any gap after the weekend
   CancelFridayOrders();

  }

bool TRADE_OR_NOT = true;
int positionType = -1;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Trading_Zone(int ADX_H1, int DI_Status_H1, int ADX_M30, int DI_Status_M30, int ADX_H4, int DI_Status_H4)
  {
   if(ADX_H1 == 1)
     {
      if(DI_Status_H1 == 1)
        {
         return 1;
        }
      else
         if(DI_Status_H1 == 0)
           {
            return 0;
           }
         else
           {
            return -1;
           }
     }
   else
     {
      return -1;
     }


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
   Print("ExtNDBuffer vs ExtNDI: "+ExtNDBuffer[1]+" VS "+ExtNDIBuffer[1]+" vs adx: "+ExtADXBuffer[29]);
//Market_Structure_2(indicator_customADX);
//Comment("ExtADXBuffer[0]: "+ExtADXBuffer[0]);
   Print("adx: "+ExtADXBuffer[29]+EnumToString(period));

   if((ExtADXBuffer[29] > 20 && ExtPDIBuffer[1] > 20 && ExtNDIBuffer[1] > 20)
      && (ExtADXBuffer[29] < 25 && ExtPDIBuffer[1] < 25 && ExtNDIBuffer[1] < 25))
     {
      return -1;
     }
   else
      if(ExtPDIBuffer[29] > 20 && ExtADXBuffer[29] > 21)
        {
         return 1;
        }
      else
         if(ExtADXBuffer[29] > 21 && ExtNDIBuffer[29] > 20)
           {
            return 1;
           }
         else
           {
            return -1;
           }

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

  }

int counter_PivotPrice = 0;



//+------------------------------------------------------------------+
//|                                                                  |
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
double Support_and_Resistance_Prices(int indicator_handleSupRes_R, int index, int BuyOrSell)
  {
   double SupportBuffer[];
   double ResiBuffer[];
   ArraySetAsSeries(SupportBuffer,true);
   ArraySetAsSeries(ResiBuffer, true);

   CopyBuffer(indicator_handleSupRes_R,0,0,50,SupportBuffer);
   CopyBuffer(indicator_handleSupRes_R,1,0,50,ResiBuffer);

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
//void PivotPricesContainer(int indicator_handlePivot_R, ENUM_TIMEFRAMES period)
//  {
//
//   ArraySetAsSeries(PivotBuffer, true);
//   ArraySetAsSeries(R1Buffer,true);
//   ArraySetAsSeries(R2Buffer,true);
//   ArraySetAsSeries(R3Buffer,true);
//   ArraySetAsSeries(S1Buffer,true);
//   ArraySetAsSeries(S2Buffer,true);
//   ArraySetAsSeries(S3Buffer,true);
//
//   CopyBuffer(indicator_handlePivot_R,0,0,50,PivotBuffer);
//   CopyBuffer(indicator_handlePivot_R,1,0,50,R1Buffer);
//   CopyBuffer(indicator_handlePivot_R,2,0,50,R2Buffer);
//   CopyBuffer(indicator_handlePivot_R,3,0,50,R3Buffer);
//   CopyBuffer(indicator_handlePivot_R,4,0,50,S1Buffer);
//   CopyBuffer(indicator_handlePivot_R,5,0,50,S2Buffer);
//   CopyBuffer(indicator_handlePivot_R,6,0,50,S3Buffer);
//
//// if(counter_PivotPrice > 20), where 20 comes from (n-1) where n=(3*7) where 3 represents the number of
//// pivot sources( different PERIODS) and 7 represents the number of the indicator's buffers
//   if(counter_PivotPrice > 20)
//     {
//      counter_PivotPrice = 0;
//     }
//   else
//     {
//      PivotBufferPrices[counter_PivotPrice]=PivotBuffer[1];
//      PivotBufferPrices[counter_PivotPrice + 1]=R1Buffer[1];
//      PivotBufferPrices[counter_PivotPrice + 2]=R2Buffer[1];
//      PivotBufferPrices[counter_PivotPrice + 3]=R3Buffer[1];
//      PivotBufferPrices[counter_PivotPrice + 4]=S1Buffer[1];
//      PivotBufferPrices[counter_PivotPrice + 5]=S2Buffer[1];
//      PivotBufferPrices[counter_PivotPrice + 6]=S3Buffer[1];
//
//      counter_PivotPrice += 7;
//     }
//
//  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Trending_Angle(int indicator_handleTrending_Angle_R, ENUM_TIMEFRAMES period, MqlRates &ratesCurr[])
  {
// Used by s_rind. Trendline
   double support_DataTrendLine[20], resistance_DataTrendLine[20];
   ArraySetAsSeries(support_DataTrendLine,true);
   ArraySetAsSeries(resistance_DataTrendLine, true);

   CopyBuffer(indicator_handleTrending_Angle_R,0,0,20,support_DataTrendLine);
   CopyBuffer(indicator_handleTrending_Angle_R,1,0,20,resistance_DataTrendLine);


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
//|                                                                  |
//+------------------------------------------------------------------+
int BreakStructureTrendline(int indicator_handleTrending_Angle_R, ENUM_TIMEFRAMES period, MqlRates &ratesCurr[]) // Break Of Structure Confluence:
  {

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
int Trendline_AreaCheck(int indicator_handleTrendLine_R, ENUM_TIMEFRAMES period, MqlRates &ratesCurr[], int radiusArea)
  {
// Used by s_rind. Trendline
   double support_DataTrendLine[20], resistance_DataTrendLine[20];
   ArraySetAsSeries(support_DataTrendLine,true);
   ArraySetAsSeries(resistance_DataTrendLine, true);

   CopyBuffer(indicator_handleTrendLine_R,0,0,20,support_DataTrendLine);
   CopyBuffer(indicator_handleTrendLine_R,1,0,20,resistance_DataTrendLine);

   if(MathAbs(ratesCurr[1].close - resistance_DataTrendLine[19]) <= radiusArea*_Point)
     {
      // Get ready to go down, probably
      return 0;
     }
   else
      if(MathAbs(ratesCurr[1].close - support_DataTrendLine[19]) <= radiusArea*_Point)
        {
         // Get ready to go up, probably
         return 1;
        }
      else
        {
         // The price isn't close from the trendline.
         return -1;
        }


  }


double PivotBufferPrices[51];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Pivot_Support_Resistance_Area_Check(int indicator_handlePivot_R, ENUM_TIMEFRAMES period)
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
   if(Support_Resistance_Area_BluePrint(R1Buffer,S1Buffer,period,240) >= 0)
     {
      return 11;
     }
   else
      if(Support_Resistance_Area_BluePrint(R2Buffer,S2Buffer,period,240) >= 0)
        {
         return 11;
        }
      else
         if(Support_Resistance_Area_BluePrint(R3Buffer,S3Buffer,period,240) >= 0)
           {
            return 11;
           }
         else
            if(Support_Resistance_Area_BluePrint(PivotBuffer,S3Buffer,period,240) >= 0)
              {
               return 11;
              }
            else
              {
               return -11;
              }



  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Support_Resistance_Area_Check(int indicator_handleSupRes_R, ENUM_TIMEFRAMES period)
  {
   MqlRates curr_Rates[];
   ArraySetAsSeries(curr_Rates,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),curr_Rates);

   double SellBuffer[];
   double BuyBuffer[];
   ArraySetAsSeries(SellBuffer,true);
   ArraySetAsSeries(BuyBuffer, true);

   CopyBuffer(indicator_handleSupRes_R,0,0,50,SellBuffer);
   CopyBuffer(indicator_handleSupRes_R,1,0,50,BuyBuffer);

//Comment("1st: "+ (SellBuffer[1]-300*MathPow(_Point,10)) +"\n"
//        +"2nd: "+ (BuyBuffer[1] + 300*MathPow(_Point,10)));
//Comment(curr_Rates[1].close+" "+BuyBuffer[1]+"\n"+
//"Price: "+MathAbs(curr_Rates[1].close - BuyBuffer[1])+" vs bf: "+MathAbs(curr_Rates[1].close - SellBuffer[1]) );
   if(curr_Rates[1].close <= BuyBuffer[1] && curr_Rates[1].close >= (BuyBuffer[1]-300*_Point))
     {
      //Print("Resistance Lower");
      // Resistance Zone: Lower Side

      // Check if the support is in the interval also
      if(curr_Rates[1].close >= SellBuffer[1] && curr_Rates[1].close <= (SellBuffer[1] + 300*_Point) ||
         curr_Rates[1].close <= SellBuffer[1] && curr_Rates[1].close >= (SellBuffer[1] - 300*_Point))
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
// commented now.... not normally commented

   else
      if(curr_Rates[1].close >= BuyBuffer[1] && curr_Rates[1].close <= (BuyBuffer[1]+300*_Point))
        {
         //Print("Resistance Upper");
         // Resistance Zone: Upper Side

         // Check if the support is in the interval also
         if(curr_Rates[1].close >= SellBuffer[1] && curr_Rates[1].close <= (SellBuffer[1] + 300*_Point) ||
            curr_Rates[1].close <= SellBuffer[1] && curr_Rates[1].close >= (SellBuffer[1] - 300*_Point))
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
         if(curr_Rates[1].close >= SellBuffer[1] && curr_Rates[1].close <= (SellBuffer[1] + 300*_Point))
           {
            //Print("Support Upper");
            // Support Zone: Upper Side

            // Check if the resistance is in the interval also
            if(curr_Rates[1].close <= BuyBuffer[1] && curr_Rates[1].close >= (BuyBuffer[1]-300*_Point) ||
               curr_Rates[1].close >= BuyBuffer[1] && curr_Rates[1].close <= (BuyBuffer[1]+300*_Point))
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
            if(curr_Rates[1].close <= SellBuffer[1] && curr_Rates[1].close >= (SellBuffer[1] - 300*_Point))
              {
               //Print("Support Lower");
               // Support Zone: Lower Side

               // Check if the resistance is in the interval also
               if(curr_Rates[1].close <= BuyBuffer[1] && curr_Rates[1].close >= (BuyBuffer[1]-300*_Point) ||
                  curr_Rates[1].close >= BuyBuffer[1] && curr_Rates[1].close <= (BuyBuffer[1]+300*_Point))
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
int crossedStatus = -1;
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
      crossedStatus = 1;
      //Print("Crossed Up Up");


      return 1;

     }
   else
      //   Crossover bwteen 8-P and 14-P.
      if(myMovingAverageArray_lowPer_Cr[1]<myMovingAverageArray_highPer_Cr[1]
         && myMovingAverageArray_lowPer_Cr[2]>myMovingAverageArray_highPer_Cr[2]
        )
        {
         crossedStatus = 0;
         //Print("Crossed Down Down");

         return 0;

        }
      else
        {
         //Print("nOT YET");
         crossedStatus = -1;
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

   if(curr_Rates[1].close < myMovingAverageArray_lowPer[1] && curr_Rates[2].close < myMovingAverageArray_lowPer[2])
     {
      return 0;
     }
   else
     {
      return 1;
     }

  }



//+------------------------------------------------------------------+
//|This method checks if the current candle is the first one closing above/below the MA price|
//+------------------------------------------------------------------+
int MA_PriceActionFirstCandle(int indicator_customMA_1, int indicator_customMA_2, ENUM_TIMEFRAMES period)
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

   if(curr_Rates[1].close > myMovingAverageArray_lowPer[1] && curr_Rates[2].close < myMovingAverageArray_lowPer[2])
     {
      return 1;
     }
   else
      if(curr_Rates[1].close < myMovingAverageArray_lowPer[1] && curr_Rates[2].close > myMovingAverageArray_lowPer[2])
        {
         return 0;
        }
      else
        {
         return -1;
        }

  }

//+------------------------------------------------------------------+
//|This method checks if the current candle tried to close above/below MA, but it couldn't. It leaves behind a mark.
//+------------------------------------------------------------------+
int MA_PriceActionCandleRetest(int indicator_customMA_1, int indicator_customMA_2, ENUM_TIMEFRAMES period)
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

// If current candle tries to go above/below the MA, but fails and closes below/above the MA,
// then that's a good indication.
   if(curr_Rates[1].high > myMovingAverageArray_lowPer[1] && curr_Rates[1].close < myMovingAverageArray_lowPer[1])
     {
      return 0;
     }
   else
      if(curr_Rates[1].low < myMovingAverageArray_lowPer[1] && curr_Rates[1].close > myMovingAverageArray_lowPer[1])
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
double Patterns_Up(int indicator_handlePatterns_R, int index)
  {
   double downArrow[];
   ArraySetAsSeries(downArrow,true);
   CopyBuffer(indicator_handlePatterns_R,1,0,50,downArrow);

   double upArrow[];
   ArraySetAsSeries(upArrow,true);
   CopyBuffer(indicator_handlePatterns_R,0,0,50,upArrow);

   for(int i=0; i<20; i++)
     {
      if(upArrow[i] > 0)
        {
         //Print("PriceUp: "+i + "\n");
         return upArrow[i];
        }
      else
         if(downArrow[i] > 0)
           {
            return -1;
           }
      //Print("Price: "+upArrow[i] + "\n");
     }
   return upArrow[index];
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Patterns_Down(int indicator_handlePatterns_R, int index)
  {
   double upArrow[];
   ArraySetAsSeries(upArrow,true);
   CopyBuffer(indicator_handlePatterns_R,0,0,50,upArrow);

   double downArrow[];

   ArraySetAsSeries(downArrow,true);


   CopyBuffer(indicator_handlePatterns_R,1,0,50,downArrow);

   for(int i=0; i<20; i++)
     {
      if(downArrow[i] > 0)
        {
         //Print("PriceDown: "+i + "\n");
         return downArrow[i];
        }
      else
         if(upArrow[i] > 0)
           {
            return -1;
           }
      //Print("PriceDown: "+downArrow[i] + "\n");
     }
//Print("downArrow[index]: "+downArrow[index]);
   return downArrow[index];
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TrendLine_MarketStructure_PTL(int indicator_PTL_R)
  {
   double slowlu[],slowln[],fastln[],arrowar[],arrowcl[],candleo[],candleh[],candlel[],candlec[],candleC[];

   ArraySetAsSeries(candleC,true);
   CopyBuffer(indicator_PTL_R,4,0,50,candleC);

   if(candleC[1] == 1)
     {
      return 1;
     }
   else
      if(candleC[1] == 0)
        {
         return 0;
        }
      else
        {
         return -1;
        }
//Comment("candleC[1]: "+candleC[1]);
  }
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CheckNewBar(ENUM_TIMEFRAMES period_To_Use)
  {
   MqlRates      current_rates[1];
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
//|                                                                  |
//+------------------------------------------------------------------+
int MovingAverage_Near_Price(int indicator_customMA_1, int indicator_customMA_2, ENUM_TIMEFRAMES period, int areaCheck)
  {
   double myMovingAverageArray_lowPer[];
   double myMovingAverageArray_highPer[];
   MqlRates ratesCurr[];
   ArraySetAsSeries(ratesCurr,true);
   CopyRates(Symbol(),period,0,Bars(Symbol(),period),ratesCurr);


   ArraySetAsSeries(myMovingAverageArray_lowPer, true);
   ArraySetAsSeries(myMovingAverageArray_highPer, true);

   CopyBuffer(indicator_customMA_1,0,0,8,myMovingAverageArray_lowPer);
   CopyBuffer(indicator_customMA_2,0,0,8,myMovingAverageArray_highPer);

   if(MathAbs(ratesCurr[1].close - myMovingAverageArray_lowPer[1]) <= areaCheck*_Point)
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
int Supply_Demand_Indicator(int indicator_handleRetests_R, MqlRates &ratesCurr[])
  {
// Supply and demand indicator buffers
   double FastDnPts[],FastUpPts[];
   double SlowDnPts[],SlowUpPts[];

   double ner_lo_zone_P1[];
   double ner_lo_zone_P2[];
   double ner_hi_zone_P1[];
   double ner_hi_zone_P2[];
   double EntryInfo[];

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

//Comment("ner_hi_zone_P1: "+ner_hi_zone_P1[1]+"\n"
//        +"ner_hi_zone_P2: "+ner_hi_zone_P2[1]+"\n"
//        +"SlowDnPts: "+ner_lo_zone_P1[1]+"\n"
//        +"SlowUpPts: " +ner_lo_zone_P2[1]+"\n");

// Verify if current rates.Close is in between the box of Supply Demand
   if(ratesCurr[1].close <= ner_lo_zone_P1[1] && ratesCurr[1].close >= ner_lo_zone_P2[1])
     {
      // it is in the lower zone called demand; the code is 1
      return 1;
     }
   else
      if(ratesCurr[1].close >= ner_hi_zone_P1[1] && ratesCurr[1].close <= ner_hi_zone_P2[1])
        {
         // it is in the lower zone called supply; the code is 1
         return 1;
        }
      else
        {
         return -1;
        }
  }
//+------------------------------------------------------------------+







bool priceBetweenPivot;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Strategy_Num_0(int MA_CrossOver_H1, int MA_Crossover_M5, int MA_NearPrice_M5, int TradeZone)
  {
   if(MA_Crossover_M5 == 1 && MA_NearPrice_M5 == 1 && TradeZone == 1)
     {
      return 1;
     }
   else
      if(MA_Crossover_M5 == 0 && MA_NearPrice_M5 == 1 && TradeZone == 1)
        {
         return 0;
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
int Strategy_Num_1(MqlRates &ratesCurr[],double &pivotPrices[], int patternDownStatus, int patternUpStatus)
  {
//MqlRates ratesCurr[];
//ArraySetAsSeries(ratesCurr,true);
// CopyRates(Symbol(),PERIOD_M5,0,Bars(Symbol(),PERIOD_M5),ratesCurr);

   for(int i=0; i<22; i++)
     {

      if((ratesCurr[1].close >= pivotPrices[i] && ratesCurr[1].open <= pivotPrices[i]) ||
         (ratesCurr[1].close <= pivotPrices[i] && ratesCurr[1].open >= pivotPrices[i])
        )
        {
         //&& ratesCurr[1].open <= pivotPrices[i]) || (ratesCurr[1].close <= pivotPrices[i] && ratesCurr[1].open >= pivotPrices[1])
         priceBetweenPivot =  true;
         //Comment("priceBetweenPivot : "+priceBetweenPivot+" "+ratesCurr[1].close);
         if(patternUpStatus > 0 && priceBetweenPivot == true)
           {
            return 1;
           }

         if(patternDownStatus > 0 && priceBetweenPivot == true)
           {
            return 0;
           }

        }
      else
        {
         priceBetweenPivot = false;
        }
      //Print("priceBetweenPivot["+i+"]: "+pivotPrices[i]);
     }
//Comment("priceBetweenPivot : "+priceBetweenPivot+" "+patternDownStatus+" "+patternUpStatus);
   if(patternUpStatus > 0 && priceBetweenPivot == true)
     {
      return 1;
     }
   else
      if(patternDownStatus > 0 && priceBetweenPivot == true)
        {
         return 0;
        }
      else
        {
         return -1;
        }


  }
//+------------------------------------------------------------------+





//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Strategy_Num_2(int Supply_Demand_Area_Check, int Pivot_Area_Check_Confl, int MovingAverage_Near_Price_Check_H1, int pattern_Check_H4, int ADX_Check_H1,
                   int PTL_H4, int pattern_Check_H1)
  {
//        ---------- Opportunities Search -----------     //
// If current price is between the nerlo_nerhi zone or close to Pivots Points,
// then search to see if the H4-PTL is trending, the patterns are in place and price.close is 20 pips close to its MA(8),
// then search to see if the H1-PTL is trending, ADX is above 20 mark and price.close is 10 pips close to its MA(8).

//        ---------- Entry Search -----------     //
// Check the patterns/MA crossover in M15 or M5. Price needs to be below MA in H1. Take an entry when everything is set up.

// ^^^^^^^^^^^^&& Pivot_Area_Check_Confl == 1
   if(Supply_Demand_Area_Check == 1  && MovingAverage_Near_Price_Check_H1 == 1 && ADX_Check_H1 == 1)
     {
      // First check if trending upward
      if(PTL_H4 == 1)
        {
         // then check the patterns
         if(pattern_Check_H4 == 1 && pattern_Check_H1 == 1)
           {
            return 1;
           }
         else
           {
            return -1;
           }
        }// First check if trending downward
      else
         if(PTL_H4 == 0)
           {
            if(pattern_Check_H4 == 0 && pattern_Check_H1 == 0)
              {
               return 0;
              }
            else
              {
               return -1;
              }
           }
         else
           {
            return -1;
           }

     }
   else
     {
      return -1;
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Strategy_Num_3(int Patterns_M5, int MA_Cross_M5, int PivotArea_MN1, int PivotArea_D1, int MA_PriceAction_M5)
  {

   if(PivotArea_MN1 == 1 || PivotArea_D1 == 1)
     {
      if(Patterns_M5 == 1 && MA_PriceAction_M5 == 1)
        {
         return 1;
        }
      else
         if(Patterns_M5 == 0 && MA_PriceAction_M5 == 0)
           {
            return 0;
           }
         else
           {
            return -1;
           }

     }
   else
     {
      return -1;
     }

//if(MA_Cross_M5 == 1 && PTL_H4 == 1)
//  {
//   return 1;
//  }
//else
//   if(MA_Cross_M5 == 0 && PTL_H4 == 0)
//     {
//      return 0;
//     }
//   else
//     {
//      return -1;
//     }


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Strategy_Num_4(MqlRates &ratesCurr[], ENUM_TIMEFRAMES period, int ADX_H1)
  {
//MqlRates ratesCurr[];
//ArraySetAsSeries(ratesCurr,true);
// CopyRates(Symbol(),PERIOD_M5,0,Bars(Symbol(),PERIOD_M5),ratesCurr);

   if(ADX_H1 == 1)
     {
      for(int i=0; i<7; i++)
        {
         if((ratesCurr[1].close >= (PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,i) - 20*_Point) &&
             ratesCurr[1].close <= (PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,i) + 20*_Point))
            //
            //         (ratesCurr[1].close <= (PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,i) + 20*_Point)
            //          && ratesCurr[1].open >=  (PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,i) - 20*_Point))
           )
           {

            return true;
           }
        }
     }

   return false;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Strategy_Num_4_TP_Selection(string Buy_Or_Sell, MqlRates &ratesCurr[], double Bid_Or_Ask)
  {
   double PivotBufferPrices_Mix_H4_D1[14];
   double Take_Profit_Choices_Buy[14];
   double Take_Profit_Choices_Sell[14];
   ArrayFill(Take_Profit_Choices_Buy,0,14,2000000);
   ArrayFill(Take_Profit_Choices_Sell,0,14,2000000);

// Mix the buffer prices into one Array;
   for(int i=0; i<7; i++)
     {
      PivotBufferPrices_Mix_H4_D1[i] =  PivotBufferPrices(indicator_handlePivot_H4_vis_to_M5,PERIOD_H4,i);
     }
   for(int i=7; i<14; i++)
     {
      PivotBufferPrices_Mix_H4_D1[i] =PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,i-7);
     }
   ArraySort(PivotBufferPrices_Mix_H4_D1);
   Print("MIX: ");
   ArrayPrint(PivotBufferPrices_Mix_H4_D1);

   if(Buy_Or_Sell == "Buy")
     {
      for(int i=0; i<14; i++)
        {
         if(Bid_Or_Ask < PivotBufferPrices_Mix_H4_D1[i])
           {
            Take_Profit_Choices_Buy[i] = PivotBufferPrices_Mix_H4_D1[i];
           }


        }
     }
   Print("TP_CHOICES_bUY: ");
   ArrayPrint(Take_Profit_Choices_Buy);
   if(Buy_Or_Sell == "Sell")
     {
      for(int i=0; i<14; i++)
        {
         if(Bid_Or_Ask > PivotBufferPrices_Mix_H4_D1[i])
           {
            Take_Profit_Choices_Sell[i] = PivotBufferPrices_Mix_H4_D1[i];
           }

        }
     }
   Print("TP_CHOICES_Sell: ");
   ArrayPrint(Take_Profit_Choices_Sell);
   return 0;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Strategy_Num_4_SL_Possibilities(string Buy_Or_Sell, MqlRates &ratesCurr[], double Bid_Or_Ask)
  {

   double PivotBufferPrices_Mix_H4_D1[14];
   double Stop_Loss_Choices_Buy[14];
   double Stop_Loss_Choices_Sell[14];
   ArrayFill(Stop_Loss_Choices_Buy,0,14,-1);
   ArrayFill(Stop_Loss_Choices_Sell,0,14,-1);

// Mix the buffer prices into one Array;
   for(int i=0; i<7; i++)
     {
      PivotBufferPrices_Mix_H4_D1[i] = PivotBufferPrices(indicator_handlePivot_D1_vis_to_M5,PERIOD_D1,i);
     }
   for(int i=7; i<14; i++)
     {
      PivotBufferPrices_Mix_H4_D1[i] = PivotBufferPrices(indicator_handlePivot_H4_vis_to_M5,PERIOD_H4,i-7);
     }
   ArraySort(PivotBufferPrices_Mix_H4_D1);


   if(Buy_Or_Sell == "Buy")
     {
      for(int i=0; i<14; i++)
        {
         if(Bid_Or_Ask > PivotBufferPrices_Mix_H4_D1[i])
           {
            Stop_Loss_Choices_Buy[i] = PivotBufferPrices_Mix_H4_D1[i];
           }


        }
      //ArraySort(Stop_Loss_Choices_Buy);
      //Print("SL_CHOICES_Buy: Sorted ");
      //ArrayPrint(Stop_Loss_Choices_Buy);
      //for(int i=0; i<14; i++)
      //  {
      //   if(Stop_Loss_Choices_Buy[i] > 0) {}
      //{
      Print("SL > 0:  "+Stop_Loss_Choices_Buy[0]);

      ArrayPrint(Stop_Loss_Choices_Buy);

      //}
      //}
     }
   Print("SL_CHOICES_Buy: ");
   ArrayPrint(Stop_Loss_Choices_Buy);
   if(Buy_Or_Sell == "Sell")
     {
      for(int i=0; i<14; i++)
        {
         if(Bid_Or_Ask < PivotBufferPrices_Mix_H4_D1[i])
           {
            Stop_Loss_Choices_Sell[i] = PivotBufferPrices_Mix_H4_D1[i];
           }

        }

      //for(int i=0; i<14; i++)
      //  {
      //   if(Stop_Loss_Choices_Sell[i] > 0)
      //     {
      Print("SL_Sell > 0:  "+Stop_Loss_Choices_Sell[0]);
      //return Stop_Loss_Choices_Sell[0];
      ArrayPrint(Stop_Loss_Choices_Sell);
      //}


      //}
     }
   Print("SL_CHOICES_Sell: ");
   ArrayPrint(Stop_Loss_Choices_Sell);
   return 0;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Strategy_Num_5(int priceNearTrendline_D1, int priceNearTrendline_H4, int priceNearTrendline_H1,
                   int trendLineBreakStructure_D1, int trendLineBreakStructure_H4, int trendLineBreakStructure_H1,
                   int pivotAreaCheck_D1, int pivotAreaCheck_H4, int pivotAreaCheck_MN1,
                   int MA_PriceActionFirstCandle_H4, int MA_PriceActionFirstCandle_H1,
                   int MA_PriceActionCandleRetest_H4, int MA_PriceActionCandleRetest_H1,
                   int trendLine_Status_H4, int trendLine_Status_H1,
                   int patterns_M5, int MA_PriceAction_M5, int TradeZone)
  {
// The TradeZone checks if it is in the zone or not
   if(TradeZone == 1)
     {
      // first trade breakdown: >>>
      // Buy
      if(priceNearTrendline_D1 == 1)
        {
         if(trendLineBreakStructure_H4 == 1)
           {
            if(trendLineBreakStructure_H1 == 1)
              {
               if(MA_PriceActionFirstCandle_H1 == 1 || MA_PriceActionCandleRetest_H1 == 1)
                 {
                  if(pivotAreaCheck_D1 == 1)
                    {
                     if(patterns_M5 == 1 && MA_PriceAction_M5 == 1)
                       {
                        return 1;
                       }
                    }
                 }
              }
           }
        }
      // second trade breakdown: >>>
      // Buy
      if(priceNearTrendline_H4 == 1)
        {
         if(MA_PriceActionFirstCandle_H1 == 1 || MA_PriceActionCandleRetest_H1 == 1)
           {
            if(pivotAreaCheck_D1 == 1)
              {
               if(patterns_M5 == 1 && MA_PriceAction_M5 == 1)
                 {
                  return 1;
                 }
              }
           }
        }
      // third trade breakdown: >>>
      // Buy
      if(MA_PriceActionFirstCandle_H4 == 1 || MA_PriceActionCandleRetest_H4 == 1)
        {
         if(priceNearTrendline_H1 == 1)
           {
            if(MA_PriceActionFirstCandle_H1 == 1 || MA_PriceActionCandleRetest_H1 == 1)
              {
               if(pivotAreaCheck_D1 == 1)
                 {
                  if(patterns_M5 == 1 && MA_PriceAction_M5 == 1)
                    {
                     return 1;
                    }
                 }
              }
           }
        }
      // fourth trade breakdown: >>>
      // Buy
      if(MA_PriceActionFirstCandle_H4 == 1 || MA_PriceActionCandleRetest_H4 == 1)
        {
         if(trendLineBreakStructure_H1 == 1)
           {
            if(pivotAreaCheck_D1 == 1)
              {
               if(patterns_M5 == 1 && MA_PriceAction_M5 == 1)
                 {
                  return 1;
                 }
              }
           }
        }
      // fifth trade breakdown: >>>
      // Buy
      if(trendLineBreakStructure_H4 == 1)
        {
         if(trendLine_Status_H1 == 1 || trendLineBreakStructure_H1 == 1)
           {
            if(MA_PriceActionFirstCandle_H1 == 1 || MA_PriceActionCandleRetest_H1 == 1)
              {
               if(pivotAreaCheck_D1 == 1)
                 {
                  if(patterns_M5 == 1 && MA_PriceAction_M5 == 1)
                    {
                     return 1;
                    }
                 }
              }
           }

        }
     }
   else
      if(TradeZone == 0)
        {
         // first trade breakdown: >>>
         // Sell
         if(priceNearTrendline_D1 == 0)
           {
            if(trendLineBreakStructure_H4 == 0)
              {
               if(trendLineBreakStructure_H1 == 0)
                 {
                  if(MA_PriceActionFirstCandle_H1 == 0 || MA_PriceActionCandleRetest_H1 == 0)
                    {
                     if(pivotAreaCheck_D1 == 1)
                       {
                        if(patterns_M5 == 0 && MA_PriceAction_M5 == 0)
                          {
                           return 0;
                          }
                       }
                    }
                 }
              }
           }
         // second trade breakdown: >>>
         // Sell
         if(priceNearTrendline_H4 == 0)
           {
            if(MA_PriceActionFirstCandle_H1 == 0 || MA_PriceActionCandleRetest_H1 == 0)
              {
               if(pivotAreaCheck_D1 == 1)
                 {
                  if(patterns_M5 == 0 && MA_PriceAction_M5 == 0)
                    {
                     return 0;
                    }
                 }
              }
           }
         // third trade breakdown: >>>
         // Sell
         if(MA_PriceActionFirstCandle_H4 == 0 || MA_PriceActionCandleRetest_H4 == 0)
           {
            if(priceNearTrendline_H1 == 0)
              {
               if(MA_PriceActionFirstCandle_H1 == 0 || MA_PriceActionCandleRetest_H1 == 0)
                 {
                  if(pivotAreaCheck_D1 == 1)
                    {
                     if(patterns_M5 == 0 && MA_PriceAction_M5 == 0)
                       {
                        return 0;
                       }
                    }
                 }
              }
           }
         // fourth trade breakdown: >>>
         // Sell
         if(MA_PriceActionFirstCandle_H4 == 0 || MA_PriceActionCandleRetest_H4 == 0)
           {
            if(trendLineBreakStructure_H1 == 0)
              {
               if(pivotAreaCheck_D1 == 1)
                 {
                  if(patterns_M5 == 0 && MA_PriceAction_M5 == 0)
                    {
                     return 0;
                    }
                 }
              }
           }
         // fifth trade breakdown: >>>
         // Sell
         if(trendLineBreakStructure_H4 == 0)
           {
            if(trendLine_Status_H1 == 0 || trendLineBreakStructure_H1 == 0)
              {
               if(MA_PriceActionFirstCandle_H1 == 0)
                 {
                  if(pivotAreaCheck_D1 == 1)
                    {
                     if(patterns_M5 == 0 && MA_PriceAction_M5 == 0)
                       {
                        return 0;
                       }
                    }
                 }
              }

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
void CancelFridayOrders()
  {

   MqlDateTime STime;
   datetime time_current=TimeCurrent();
   datetime time_local=TimeLocal();

   TimeToStruct(time_current,STime);
//Print("Time Current ",TimeToString(time_current,TIME_DATE|TIME_SECONDS)," day of week ",DayOfWeekDescription(STime.day_of_week));
   Print("Today is: "+STime.day_of_week);

// If there is an open Position, profit is positive and the day of the week is friday, then cancel any order
   if(PositionSelect(Symbol())==true && STime.day_of_week == 5 && STime.hour >= 19)
     {
      CancelOrder();
      //triggeredSLEarly = 1;
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

double goldenMovingAverageArray[3];
double price_MA_Crossed = 0.0;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Buying_SL(double first_SL,double second_SL, double third_SL, double fourth_SL)
  {

   if(MathAbs(first_SL - rates[1].close) >= MathAbs(second_SL - rates[1].close))
     {
      second_SL - 45*_Point;
     }



// Minus 4.5 pips to the current SL
   return first_SL - 45*_Point;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Selling_SL(double first_SL,double second_SL, double third_SL, double fourth_SL)
  {
//double PivotPrices_SL_Usage[7];
//double Array_Stop_Losses[8];
   if(MathAbs(first_SL - rates[1].close) >= MathAbs(second_SL - rates[1].close))
     {
      second_SL + 45*_Point;
     }


// Plus 4.5 pips to the current SL
   return first_SL + 45*_Point;

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Buying_TP(double first_TP,double second_TP, double third_TP, double fourth_TP,double curr_SL,double Ask)
  {
//double Take_Profits[8];
//Take_Profits[0] = first_TP;
//Take_Profits[1] = second_TP;
//Take_Profits[2] = third_TP;
//Take_Profits[4] = fourth_TP
//ArraySort();
// First of all, the TP needs to respect the "at least 1 to 3 Risk-Reward ratio"
   if((2*MathAbs(Ask - curr_SL) + Ask) < first_TP && first_TP !=0)
     {
      //Print("1st TP");
      return first_TP;
     }
   else
      if((2*MathAbs(Ask - curr_SL) + Ask) < second_TP && second_TP !=0)
        {
         //Print("2ND TP");
         return second_TP;
        }
      else
         if((2*MathAbs(Ask - curr_SL) + Ask) < third_TP && third_TP !=0)
           {
            //Print("3rd TP");
            return third_TP;
           }
         else
            if((2*MathAbs(Ask - curr_SL) + Ask) < fourth_TP && fourth_TP !=0)
              {
               //Print("4TH TP");
               return fourth_TP;
              }

            else
              {
               //Print("Its because of me Last ONe !!!!!!!!");
               return (2*MathAbs(Ask - curr_SL) + Ask);
              }

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double Selling_TP(double first_TP,double second_TP, double third_TP,double fourth_TP, double curr_SL,double Bid)
  {
// First of all, the TP needs to respect the at least 1 to 3 Risk-Reward ratio
   if((Bid - 2*MathAbs(Bid - curr_SL)) > first_TP && first_TP !=0)
     {
      //Print("1st TP");
      return first_TP;
     }
   else
      if((Bid - 2*MathAbs(Bid - curr_SL)) > second_TP && second_TP !=0)
        {
         //Print("2ND TP");
         return second_TP;
        }
      else
         if((Bid - 2*MathAbs(Bid - curr_SL)) > third_TP && third_TP !=0)
           {
            //Print("3rd TP");
            return third_TP;
           }
         else
            if((Bid - 2*MathAbs(Bid - curr_SL)) > fourth_TP && fourth_TP !=0)
              {
               //Print("4TH TP");
               return fourth_TP;
              }
            else
              {
               //Print("Its because of me Last One !!!!!!!!");
               return (Bid - 2*MathAbs(Bid - curr_SL));
              }

  }
//+------------------------------------------------------------------+




const double XAG_USD_MagicNumber =5;
const double GBP_AUD_MagicNumber =0.673980;
const double XAU_USD_MagicNumber = 1;
const double EUR_USD_MagicNumber = 1;
const double USD_JPY_MagicNumber = 0.910341;
const double GBP_JPY_MagicNumber =0.910341;
const double USD_CAD_MagicNumber = 0.752819;
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

string  arr[21];
int i = 0;
int data[8];

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void fileWriting(const string InpFileName_NonReadable,const string InpFileName_Readable, int &confluencesDefaultArray[], int &confluencesDefaultArrayInventory[][])
  {

   ArrayFill(data,0,3,524);
   int file_handle=FileOpen(InpFileName_NonReadable,FILE_WRITE|FILE_READ|FILE_COMMON|FILE_BIN);
   int file_handle_Readable=FileOpen(InpFileName_Readable,FILE_WRITE|FILE_READ|FILE_COMMON|FILE_TXT," ");

   if(file_handle!=INVALID_HANDLE)
     {
      PrintFormat("%s file is available for writing",InpFileName_NonReadable);
      PrintFormat("File path: %s\\Files\\",TerminalInfoString(TERMINAL_DATA_PATH));



      FileWriteArray(file_handle,confluencesDefaultArrayInventory);

      for(int rowEntry = 0; rowEntry < DEFAULT_NUMBER_STRATEGIES; rowEntry++)
        {
         for(int colEntry = 0; colEntry < DEFAULT_NUMBER_ENTRIES; colEntry++)
           {
            //FileSeek(file_handle_Readable,0,SEEK_END);
            FileWriteString(file_handle_Readable,
                            IntegerToString(confluencesDefaultArrayInventory[rowEntry][colEntry])+" "
                            //data[1]+
                            //data[2]+
                            //data[3]+
                            //data[4]+
                            //data[5]+
                            //data[6]+
                            //data[7]
                           );
           }
         FileWriteString(file_handle_Readable,
                         "\n"
                        );
        }
      //       for(int rowEntry = 0; rowEntry < rowCounterSell; rowEntry++)
      //           {
      //            for(int colEntry = 0; colEntry < DEFAULT_NUMBER_ENTRIES; colEntry++)
      //              {
      //
      //              }
      //           }

      //--- close the file
      FileClose(file_handle);
      FileClose(file_handle_Readable);

      PrintFormat("Data is written, %s file is closed",InpFileName_NonReadable);
     }
   else
      PrintFormat("Failed to open %s file, Error code = %d",InpFileName_NonReadable,GetLastError());





  }

//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void fileWriting_Reward(const string InpFileName_NonReadable,const string InpFileName_Readable, int &confluencesDefaultArray[])
  {

//ArrayFill(data,0,3,524);
   int file_handle=FileOpen(InpFileName_NonReadable,FILE_WRITE|FILE_READ|FILE_COMMON|FILE_BIN);
   int file_handle_Readable=FileOpen(InpFileName_Readable,FILE_WRITE|FILE_READ|FILE_COMMON|FILE_TXT," ");

   if(file_handle!=INVALID_HANDLE || file_handle_Readable!=INVALID_HANDLE)
     {
      PrintFormat("%s file is available for writing",InpFileName_NonReadable);
      PrintFormat("File path: %s\\Files\\",TerminalInfoString(TERMINAL_DATA_PATH));



      FileWriteArray(file_handle,confluencesDefaultArray);
      for(int rowEntry = 0; rowEntry < ArraySize(confluencesDefaultArray); rowEntry++)
        {
         //FileSeek(file_handle_Readable,0,SEEK_END);
         FileWriteString(file_handle_Readable,
                         IntegerToString(confluencesDefaultArray[rowEntry])+" "
                         //data[1]+
                         //data[2]+
                         //data[3]+
                         //data[4]+
                         //data[5]+
                         //data[6]+
                         //data[7]
                        );
        }
      FileWriteString(file_handle_Readable,
                      "\n"
                     );

      //       for(int rowEntry = 0; rowEntry < rowCounterSell; rowEntry++)
      //           {
      //            for(int colEntry = 0; colEntry < DEFAULT_NUMBER_ENTRIES; colEntry++)
      //              {
      //
      //              }
      //           }

      //--- close the file
      FileClose(file_handle);
      FileClose(file_handle_Readable);

      PrintFormat("Data is written, %s file is closed",InpFileName_NonReadable);
     }
   else
      PrintFormat("Failed to open %s file, Error code = %d",InpFileName_NonReadable,GetLastError());





  }



//+------------------------------------------------------------------+
//|         Using |FILE_COMMON to each file_Handle  is the key        |
//+------------------------------------------------------------------+
void fileReading(string fileToRead)
  {
   int arr[2][25];
   int file_handle=FileOpen(fileToRead,FILE_READ|FILE_BIN|FILE_COMMON);
   if(file_handle!=INVALID_HANDLE)
     {
      //--- read all data from the file to the array
      FileReadArray(file_handle,arr);
      //--- receive the array size
      int size=ArraySize(arr);
      //--- print data from the array
      //for(int j=0; j<5; j++)
      //  {
      //   for(int i=0; i<2; i++)
      //     {
      //      Print("Values ",arr[j][i]+"["+j+"]"+"["+i+"]");
      //     }
      //  }
      //ArrayPrint(arr);


      Print("Total data = ",size);
      //--- close the file
      FileClose(file_handle);
     }
   else
      Print("File open failed, error ",GetLastError());
  }
//+------------------------------------------------------------------+

double VolumeValue_Buy[21];
double Price_SL_Buy[21];
double Price_TP_Buy[21];
double VolumeValue_Sell[21];
double Price_SL_Sell[21];
double Price_TP_Sell[21];
int counter_OrderInfo_Buy = 0;
int counter_OrderInfo_Sell = 0;
int Current_SL = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction& trans,
                        const MqlTradeRequest& request,
                        const MqlTradeResult& result)
  {
   if(HistoryDealSelect(trans.deal) == true)
     {
      ENUM_DEAL_ENTRY deal_entry=(ENUM_DEAL_ENTRY) HistoryDealGetInteger(trans.deal,DEAL_ENTRY);
      ENUM_DEAL_REASON deal_reason=(ENUM_DEAL_REASON) HistoryDealGetInteger(trans.deal,DEAL_REASON);
      //ENUM_DEAL_PROPERTY_INTEGER deal_positionID = (ENUM_DEAL_PROPERTY_INTEGER) HistoryDealGetInteger(trans.deal,DEAL_POSITION_ID);
      PrintFormat("deal entry type=%s trans type=%s trans deal type=%s order-ticket=%d deal-ticket=%d deal-reason=%s"
                  ,EnumToString(deal_entry),EnumToString(trans.type)
                  ,EnumToString(trans.deal_type),trans.order,trans.deal
                  ,EnumToString(deal_reason));

      Current_SL = trans.price_sl;

      //      if(EnumToString(deal_entry) == "DEAL_ENTRY_IN")
      //        {
      //         Deal_EntryIn = true;
      //         if(EnumToString(trans.deal_type) == "DEAL_TYPE_SELL")
      //
      //           {
      //            VolumeValue_Sell[counter_OrderInfo_Sell] = trans.volume;
      //            Price_TP_Sell[counter_OrderInfo_Sell] =  trans.price_tp;
      //            Price_SL_Sell[counter_OrderInfo_Sell] = trans.price_sl;
      //            orderNumber_Status_Sell[counter_OrderInfo_Sell] = trans.order;
      //            ++counter_OrderInfo_Sell;
      //           }
      //         if(EnumToString(trans.deal_type) == "DEAL_TYPE_BUY")
      //           {
      //            VolumeValue_Buy[counter_OrderInfo_Buy] = trans.volume;
      //            Price_TP_Buy[counter_OrderInfo_Buy] =  trans.price_tp;
      //            Price_SL_Buy[counter_OrderInfo_Buy] = trans.price_sl;
      //            orderNumber_Status_Buy[counter_OrderInfo_Buy] = trans.order;
      //            ++counter_OrderInfo_Buy;
      //           }
      //
      //        }

      //      if(EnumToString(deal_entry) == "DEAL_ENTRY_OUT")
      //        {
      //
      //         if(EnumToString(deal_reason) == "DEAL_REASON_SL")
      //           {
      //            if(EnumToString(trans.deal_type) == "DEAL_TYPE_SELL")
      //              {
      //               for(int i=0; i<ArraySize(orderNumber_Status_Buy); i++)
      //                 {
      //                  if(Price_TP_Buy[i] == trans.price_tp && Price_SL_Buy[i] == trans.price_sl && VolumeValue_Buy[i]==trans.volume)
      //                    {
      //                     RewardSystem_Buy[rowNumber_Status_BuyArray[i]] = -1;
      //                    }
      //                 }
      //              }
      //            if(EnumToString(trans.deal_type) == "DEAL_TYPE_BUY")
      //              {
      //               for(int i=0; i<ArraySize(orderNumber_Status_Sell); i++)
      //                 {
      //                  if(Price_TP_Sell[i] == trans.price_tp && Price_SL_Sell[i] == trans.price_sl && VolumeValue_Sell[i]==trans.volume)
      //                    {
      //                     RewardSystem_Sell[rowNumber_Status_SellArray[i]] = -1;
      //                    }
      //                 }
      //              }
      //
      //
      //
      //           }
      //
      //         if(EnumToString(deal_reason) == "DEAL_REASON_TP")
      //           {
      //            if(EnumToString(trans.deal_type) == "DEAL_TYPE_SELL")
      //              {
      //               for(int i=0; i<ArraySize(orderNumber_Status_Buy); i++)
      //                 {
      //                  if(Price_TP_Buy[i] == trans.price_tp && Price_SL_Buy[i] == trans.price_sl && VolumeValue_Buy[i]==trans.volume)
      //                    {
      //                     RewardSystem_Buy[rowNumber_Status_BuyArray[i]] = 1;
      //                    }
      //                 }
      //              }
      //            if(EnumToString(trans.deal_type) == "DEAL_TYPE_BUY")
      //              {
      //               for(int i=0; i<ArraySize(orderNumber_Status_Sell); i++)
      //                 {
      //                  if(Price_TP_Sell[i] == trans.price_tp && Price_SL_Sell[i] == trans.price_sl && VolumeValue_Sell[i]==trans.volume)
      //                    {
      //                     RewardSystem_Sell[rowNumber_Status_SellArray[i]] = 1;
      //                    }
      //                 }
      //              }
      //           }
      //
      //        }


      //Print("ticket ",trans.order);
      //Print("ID: "+EnumToString(deal_positionID));




      //      if(AccountInfoDouble(ACCOUNT_EQUITY) > AccountInfoDouble(ACCOUNT_BALANCE))
      //        {
      //         CancelOrder(trans.deal);
      //
      //        }

     }

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TraillingStopLoss(double NewStopLoss)
  {
// desired stop loss

   for(i=PositionsTotal(); i>=0; i--)
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
void changeSLSelling(double usualStopLoss, double newStopLoss)
  {
   if(usualStopLoss >= newStopLoss)
     {
      TraillingStopLoss(newStopLoss);
     }

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void changeSLBuying(double usualStopLoss, double newStopLoss)
  {
   if(usualStopLoss !=0 && usualStopLoss < newStopLoss)
     {
      TraillingStopLoss(newStopLoss);
     }
//TraillingStopLoss(newStopLoss);

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ResetOrdersInfo()
  {
   ArrayFill(orderNumber_Status_Buy,0,21,0);
   ArrayFill(orderNumber_Status_Sell,0,21,0);
   ArrayFill(Price_TP_Buy,0,21,0);
   ArrayFill(Price_TP_Sell,0,21,0);
   ArrayFill(Price_SL_Buy,0,21,0);
   ArrayFill(Price_SL_Sell,0,21,0);

   counter_OrderInfo_Buy = 0;
   counter_OrderInfo_Sell = 0;
   rowNumberPosition_BuyCounter = 0;
   rowNumberPosition_SellCounter = 0;
  }

int rowNumber_Status_BuyArray[21];
int rowNumber_Status_SellArray[21];
int orderNumber_Status_Buy[21];
int orderNumber_Status_Sell[21];
int RewardSystem_Buy[70];
int RewardSystem_Sell[70];
int rowNumberPosition_BuyCounter = 0;
int rowNumberPosition_SellCounter = 0;
int orderNumberPosition_BuyCounter = 0;
int orderNumberPosition_SellCounter = 0;
bool Deal_EntryIn = true;
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
