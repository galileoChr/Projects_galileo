//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//#include <CandlestickType.mqh>
#include <Trade\Trade.mqh>
CTrade trade;
#include <MovingAverages.mqh>
//#include <MATrendDetector.mqh>


#property indicator_chart_window
input int MyTakeProf = 100;
//--- plot 1
#property indicator_label1  ""
#property indicator_type1   DRAW_LINE
#property indicator_color1  Blue
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
#property indicator_buffers 5
#property indicator_plots   1
//--- input parameters
input int   InpPeriodSMA   =8;         // Period of averaging
input bool  InpAlert       =true;       // Enable. signal
input int   Inpcount_100Bars   =1000;       // Amount of bars for calculation
input color InpColorBull   =DodgerBlue; // Color of bullish models
input color InpColorBear   =Tomato;     // Color of bearish models
input bool  InpCommentOn   =true;       // Enable comment
input int   InpTextFontSize=10;         // Font size
const double vol = 0.2;
//---- indicator buffers
//--- indicator handles
//--- list global variable
string prefix="Patterns ";
datetime CurTime=0;
int count_100 = 0;
double slopeLong;
int movingAverageDef,movingAverageDef2;

int indicator_handleKeyL;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnInit()
  {

//movingAverageDef = iMA(_Symbol,_Period,optimizePeriod2(50),0,MODE_SMA,PRICE_CLOSE);
   indicator_handleKeyL  = iCustom(Symbol(),Period(),"Key_Levels");
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int loop =2;
int count = 0;
static double angleVariation[90];
bool angleBool = false;
int trend_direction = 0;
int countLoop = 0;
int testCount = 0;
double tp = 200;
//int h=FileOpen("test.txt",FILE_READ|FILE_WRITE|FILE_ANSI|FILE_TXT);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {

//  Wait for beginning of a new bar:
   if(CheckNewBar()!=1)
     {
      return;
     }

   int arrayCycle[5];
   double testingArrayFuture[20];
   double resultPix_PriceY, resultPix_BarsX, resultPix_PriceY_2,  resultPix_BarsX_2;
   double angleLongUp;
   double hypothenuse;
   double x_over_hypo;
   string comment;
   int LowestCand, HighestCandl,lowestCand2, HighestCandl2, HighestCandlShort, HighestCandl2Short;
   double price1Long,price0Long;
   double slopeRef;
   int CaNumber2 =30;
   double lowP[];
   double highP[];
   double price_100_Retr ;
   double price_0_Retr  ;
   double fiboRange, fib_1_000, fib_0_618,fib_0_500,fib_0_382,fib_0_236,fib_0_000, fib_2_618,fib_1_618,fib_4_236;
   double Ask = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
   double Bid = NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);


   
   count++;
   ArraySetAsSeries(lowP,true);
   ArraySetAsSeries(highP,true);
   movingAverageDef2 = iMA(_Symbol,_Period,25,0,MODE_SMA,PRICE_CLOSE);


//CANDLE_STRUCTURE cand1;



   CopyHigh(_Symbol,_Period,0,100,highP);
   CopyLow(_Symbol,_Period,0,100,lowP);
   HighestCandl = ArrayMaximum(highP,CaNumber2,100);
   HighestCandl2 = ArrayMaximum(highP,0,CaNumber2);
   HighestCandlShort = ArrayMaximum(highP,9,20);
   HighestCandl2Short = ArrayMaximum(highP,0,9);
   LowestCand = ArrayMinimum(lowP,0,150);
   lowestCand2 = ArrayMinimum(lowP,0,45);


   MqlRates priceInfo[];
   ArraySetAsSeries(priceInfo,true);
   int Data = CopyRates(Symbol(),Period(),0,Bars(Symbol(),Period()),priceInfo);

   int lowestArray[5];
   for(int i=0; i<5; i++)
     {
      lowestArray[i] = ArrayMinimum(lowP,0,8*(i+1));
      Print("Lowest array: "+i+" "+lowestArray[i]);


     }

   for(int j=0; j<4; j++)
     {
      Print("Maximum in lowest array : >> " + ArrayMaximum(lowestArray));

      if(lowestArray[j] == lowestArray[j+1] && lowestArray[0] < lowestArray[4]
         && lowestArray[4] == lowestArray[3])
        {

         //countLoop += 1;
         Print("array Cycle: >>?? "+ " ("+j+") "+lowestArray[j] +" ");
         //Print("count loop >> "+ countLoop);
         //ObjectDelete(_Symbol,"tr");
         //Print("It is done Sir >>>>>>> ");



        }

      // let us define trends with this and see the accuracy.

     }
//Print(" Testing open/close/high >>>>  " + priceInfo[1].open + " "+priceInfo[1].close + " "+priceInfo[1].high);
   ObjectDelete(_Symbol,"tr");
   ObjectCreate(_Symbol,"tr",OBJ_TREND,0,
                priceInfo[lowestArray[ArrayMaximum(lowestArray)]].time,
                priceInfo[lowestArray[ArrayMaximum(lowestArray)]].low,
                priceInfo[ArrayMinimum(lowP,0,lowestArray[(int)(ArrayMaximum(lowestArray)/2)])].time,
                priceInfo[ArrayMinimum(lowP,0,lowestArray[(int)(ArrayMaximum(lowestArray)/2)])].low
               );
   ObjectSetInteger(_Symbol,"tr",OBJPROP_COLOR,Yellow);
//ObjectSetInteger(_Symbol,"yoo",OBJPROP_DEGREE,90);
   ObjectSetInteger(_Symbol,"tr",OBJPROP_RAY_LEFT,false);
   ObjectSetInteger(_Symbol,"tr",OBJPROP_RAY_RIGHT,false);


//if(lowestArray[0]==lowestArray[1]
//   && lowestArray[1]==lowestArray[2]
//   && lowestArray[2]==lowestArray[3]
//   && lowestArray[3]==lowestArray[4])
//  {
//   Comment("Downtrend !!!!");
//  }
//else
//   if(lowestArray[0]<= lowestArray[1]
//      && lowestArray[1]<= lowestArray[2]
//      && lowestArray[2]<= lowestArray[3]
//      && lowestArray[3]<= lowestArray[4])
//     {
//      Comment("Uptrend !!!");
//     }
//   else
//     {
//      Comment("No Trend !!!@");
//     }

//ObjectCreate(_Symbol,"lowArr",OBJ_VLINE,0,priceInfo[lowestArray[0]].time,priceInfo[lowestArray[0]].low);
//ObjectSetInteger(_Symbol,"lowArr",OBJPROP_COLOR,Red);


   for(int i=0; i<5; i++)
     {
      ObjectDelete(_Symbol,"lowArr");
      ObjectCreate(_Symbol,"lowArr",OBJ_VLINE,0,priceInfo[lowestArray[i]].time,priceInfo[lowestArray[i]].low);
      ObjectSetInteger(_Symbol,"lowArr",OBJPROP_COLOR,Red);


     }

//ObjectDelete(_Symbol,"yoDownTrend");

   ObjectDelete(_Symbol,"yoo");

// ****  This is the Down Trend lines: long term and short term   ****** //

//   ObjectCreate(_Symbol,"yoDownTrend",OBJ_TREND,0,priceInfo[HighestCandl2].time,priceInfo[HighestCandl2].high,priceInfo[HighestCandl].time,priceInfo[HighestCandl].high);
//   ObjectSetInteger(_Symbol,"yoDownTrend",OBJPROP_COLOR,White);
////ObjectSetInteger(_Symbol,"yoo",OBJPROP_DEGREE,90);
//   ObjectSetInteger(_Symbol,"yoDownTrend",OBJPROP_RAY_LEFT,true);
//   ObjectSetInteger(_Symbol,"yoDownTrend",OBJPROP_RAY_RIGHT,false);
//   ObjectCreate(_Symbol,"DownTrendShort",OBJ_TREND,0,priceInfo[HighestCandl2Short].time,priceInfo[HighestCandl2Short].high,priceInfo[HighestCandlShort].time,priceInfo[HighestCandlShort].high);
//   ObjectSetInteger(_Symbol,"DownTrendShort",OBJPROP_COLOR,White);
////ObjectSetInteger(_Symbol,"yoo",OBJPROP_DEGREE,90);
//   ObjectSetInteger(_Symbol,"DownTrendShort",OBJPROP_RAY_LEFT,false);
//   ObjectSetInteger(_Symbol,"DownTrendShort",OBJPROP_RAY_RIGHT,false);

// *****  This is the fibonacci objects   **********  //
   ObjectDelete(_Symbol,"virv");
   ObjectCreate(_Symbol,"virv",OBJ_FIBO,0,priceInfo[50].time,priceInfo[HighestCandl].high,priceInfo[0].time,priceInfo[LowestCand].low);
   ObjectSetInteger(_Symbol,"virv",OBJPROP_COLOR,Red);
   price_100_Retr = ObjectGetDouble(_Symbol,"virv",OBJPROP_PRICE,0);
   price_0_Retr = ObjectGetDouble(_Symbol,"virv",OBJPROP_PRICE,1);

//This is the up Trend lines: long term
   ObjectCreate(_Symbol,"yoo",OBJ_TREND,0,priceInfo[lowestCand2].time,priceInfo[lowestCand2].low,priceInfo[LowestCand].time,priceInfo[LowestCand].low);
   ObjectSetInteger(_Symbol,"yoo",OBJPROP_COLOR,White);
//ObjectSetInteger(_Symbol,"yoo",OBJPROP_DEGREE,90);
   ObjectSetInteger(_Symbol,"yoo",OBJPROP_RAY_LEFT,true);
   ObjectSetInteger(_Symbol,"yoo",OBJPROP_RAY_RIGHT,true);
//double an = ObjectGetDouble(_Symbol,"yoo",OBJPROP_ANGLE,0);


// This is the fibonacci lines well defined.
   fiboRange = price_100_Retr - price_0_Retr;
   fib_1_000 = price_100_Retr;
   fib_0_618 = (fiboRange * 0.618) +price_0_Retr;
   fib_0_500 = fiboRange * 0.500  +price_0_Retr;
   fib_0_382 = fiboRange * 0.382 +price_0_Retr;
   fib_0_236 = fiboRange * 0.236 +price_0_Retr;
   fib_0_000 = price_0_Retr;
   fib_1_618 = fiboRange * 1.618 + price_0_Retr;
   fib_2_618 = fiboRange * 2.618 + price_0_Retr;
   Print(fiboRange," ",fib_1_000, "  ", fib_0_618);
   Print("Chart YDistance brother >> "+CHART_HEIGHT_IN_PIXELS+ " xDISTANCE >> "+CHART_WIDTH_IN_PIXELS);
   Print("Chart YDistance brother >> "+CHART_HEIGHT_IN_PIXELS+ " xbARS >> "+ChartGetInteger(0,CHART_VISIBLE_BARS,0));
   Print("Chart MAXIMUM >> "+ChartGetDouble(_Symbol,CHART_PRICE_MAX,0)+ " Chart MINIMUM >> "+ChartGetDouble(_Symbol,CHART_PRICE_MIN,0));
//Comment("Chart YDistance brother >> "+CHART_HEIGHT_IN_PIXELS);


// Definition of long term slope:
   price1Long = ObjectGetDouble(_Symbol,"yoo",OBJPROP_PRICE,1);
   price0Long = ObjectGetDouble(_Symbol,"yoo",OBJPROP_PRICE,0);

//  *********** Convert price differences into chart pixels coordinates .  **************************  //

// X-Y axis conversion of Point 1 //

   resultPix_PriceY = getPrice_Pixel_Conversion(price1Long);

   resultPix_BarsX = getTime_Pixel_Conversion(LowestCand);
   Print(resultPix_PriceY+" << priceY in pix "+resultPix_BarsX + " barsX in pix ");

// X-Y axis conversion of Point 2 //

   resultPix_PriceY_2 = getPrice_Pixel_Conversion(price0Long);

   resultPix_BarsX_2 = getTime_Pixel_Conversion(lowestCand2);

   hypothenuse = MathSqrt(MathPow((resultPix_BarsX_2 - resultPix_BarsX),2) + MathPow((resultPix_PriceY_2 - resultPix_PriceY),2)) ;
   if(LowestCand == 0 || hypothenuse==0)
     {
      slopeLong = 0;
      angleLongUp = 0;
      x_over_hypo = 0;
     }
   else
     {
      //Print("yValue>> "+ ((price1Long - price0Long)*100000/30)+" hypo>> "+ hypothenuse + "  xValueor LowestCand  >> " +(LowestCand));
      slopeLong = -(price1Long - price0Long)*1000000/(LowestCand);
      x_over_hypo = MathRound((resultPix_BarsX_2 - resultPix_BarsX))/((double)hypothenuse);
      angleLongUp = (acos(x_over_hypo)*180/M_PI) ;

     }
   Comment("Angle:  " + angleLongUp);
   checkCategory(angleLongUp);

   if(countLoop > 3)
     {
      countLoop =0;
      testingArrayFuture[countLoop] = angleLongUp;
     }
   else
     {
      countLoop += 1;
      testingArrayFuture[countLoop] = angleLongUp;
     }


   for(int i=0; i<3; i++)
     {
      Print("Testing past and present storing variables: " +" ["+i+"] "+ testingArrayFuture[i]);
     }

// **************************  Moving average defintion  ******************************** //

   double myMovingAverageArray[];
// Def.

   ArraySetAsSeries(myMovingAverageArray, true);
   CopyBuffer(movingAverageDef2,0,0,8,myMovingAverageArray);

// current candle
   double myMovingAverageValue = myMovingAverageArray[0];
   double current_ma;


// Uptrend or DownTrend // **************


//   else
   if(
//myMovingAverageArray[7] < priceInfo[7].high && myMovingAverageArray[7] > priceInfo[7].low
//|| myMovingAverageArray[6] < priceInfo[6].high && myMovingAverageArray[6] > priceInfo[6].low
//|| myMovingAverageArray[5] < priceInfo[5].high && myMovingAverageArray[5] > priceInfo[5].low
//|| myMovingAverageArray[4] < priceInfo[4].high && myMovingAverageArray[4] > priceInfo[4].low
      myMovingAverageArray[2] < priceInfo[2].high && myMovingAverageArray[2] > priceInfo[2].low
      || myMovingAverageArray[1] < priceInfo[1].high && myMovingAverageArray[1] > priceInfo[1].low
//|| myMovingAverageArray[0] < priceInfo[0].high && myMovingAverageArray[0] > priceInfo[0].low
   )
     {
      //Comment("No TREND FOR NOW  !!!!");
      trend_direction = 0;
     }
   else
      if(myMovingAverageValue>myMovingAverageArray[1])
        {
         trend_direction=1;
         //Comment("Uptrend Uptrend Uptrend Uptrend Uptrend Uptrend Uptrend ");
        }
      else
         if(myMovingAverageValue<myMovingAverageArray[1])
           {
            //Comment("Downtrend Downtrend Downtrend Downtrend Downtrend Downtrend ");
            trend_direction=-1;
           }
//   for(int j=0; j<4; j++)
//     {
//      if(lowestArray[j] == lowestArray[j+1] && trend_direction == 1 || trend_direction == 0)
//        {
//
//         //countLoop += 1;
//         Print("array Cycle: >>?? "+ lowestArray[j]);
//        }
//      // let us define trends with this and see the accuracy.
//
//      //lowestArray[i] = ArrayMinimum(lowP,0,8*(i+1));
//      //Print("Lowest array: "+i+" "+lowestArray[i]);
//
//
//     }
//ObjectCreate(_Symbol,"MAmin",OBJ_ARROW_CHECK,0,priceInfo[ArrayMinimum(myMovingAverageArray,0,WHOLE_ARRAY)].time,priceInfo[ArrayMinimum(myMovingAverageArray,0,WHOLE_ARRAY)].low);
//ObjectSetInteger(_Symbol,"MAmin",OBJPROP_DEGREE,64);
//ObjectSetInteger(_Symbol,"MAmin",OBJPROP_COLOR,Green);
//   if(count >= 90)
//     {
//      count=0;
//     }
//   else
//     {
//
//     }
//Print("Count :  "+count);

// ***************************** Draw trend line break ******************************* //
   if(angleBool == false && trend_direction == 0)
     {
      Print("It worked yoooooooooooo. You locked me in.");
      storeAngleInfo(priceInfo[lowestCand2].time,priceInfo[lowestCand2].low,priceInfo[LowestCand].time,priceInfo[LowestCand].low);
      angleBool = true;
      //   for(int i=0; i<10; i++)
      //     {
      //      angleVariation[i] = angleLongUp;
      //      Print("Angle array variation:  "+angleVariation[i]);
      //
      //         FileWrite(h,price0Long+" "+price1Long + " "+ LowestCand + " "+lowestCand2);
      //         Print("It is written man...");
      //         string str=FileReadString(h);
      //         FileSeek(h,0,SEEK_END);
      //
      //        }
     }

//FileClose(h);
//Print("Angle array variation:  "+angleVariation[0]);





// Print angle and slope.
//Comment("angle LongUP: "+""+angleLongUp + "  slope >>> "+slopeLong);
//Comment("Coordinate most left side point in pixels:   " + resultPix_BarsX + " " + resultPix_PriceY+"  " + resultPix_BarsX_2 + " " + resultPix_PriceY_2);
//Comment("Coordinate most right side point in pixels:   " + resultPix_BarsX_2 + " " + resultPix_PriceY_2);

//Print("adjecent line:  "+x_over_hypo+" angle LongUP:  "+ angleLongUp);



//   IndicatorRelease(movingAverageDef);
//   IndicatorRelease(movingAverageDef2);
   double bal = AccountInfoDouble(ACCOUNT_BALANCE);
   double equity = AccountInfoDouble(ACCOUNT_EQUITY);
   bool checker = false;
   bool repeatCheck = false;
   bool booleanRegulator = false;
   int countArray[85];
   int countPos = countPositions();
   
   loop +=1;
   if(slopeLong > 0)
     {
      //Print("I'm screaming ahhhhhhhh Sell sellllll sellll selll??? ///*****");
      trade.Sell(vol,NULL,Bid,0,(Bid - tp * _Point),NULL);
      
      
     }
     Print("Test cocunt: "+ testCount);
     testCount ++;
     if(testCount >= 15)
        {
         tp = 50;
        }

// ************************** Detecting Prime numbers entries ********************************* //
   for(int loop=0; loop<5; loop++)
     {

      countArray[loop]
         = count_100 ;

     }




   if(priceInfo[0].close >= fib_0_618)
     {
      Print("It's there thereeeeeeeee");
     }
   else
     {
      Print("nopeeeeeeeeee");
     }
   if(priceInfo[0].high > fib_1_000 && priceInfo[0].low < fib_1_000)
     {

      checker = true;
      count_100 +=1;

     }
   double diff = MathAbs(fib_1_618 - fib_1_000) ;

   if(countArray[4] != count_100)
     {
      Print("Not repeated");

     }
   else
     {
      repeatCheck = true;
      Print("repeated " +diff);
     }



   if(count_100 % 2 !=0 && count_100 % 3 !=0 && count_100 % 5 !=0 && count_100 % 7 !=0 && countPos<=2)
     {
      Print("Buy buyyy  " + count_100);
      //trade.PositionOpen(_Symbol,ORDER_TYPE_BUY,2,Ask,
      //                      (Ask + 125 * _Point),NULL);
      //trade.Buy(vol,NULL,Ask,0,(Ask + 125 * _Point),NULL);
      //trade.PositionCloseBy(_Symbol,(Ask + 125 * _Point));
      //booleanRegulator = true;

     }
//else
//{
//trade.PositionClose(_Symbol,3);
//}

   if(count_100 % 2 !=0 && count_100 % 3 !=0 && count_100 % 5 !=0 && count_100 % 7 !=0  && priceInfo[0].open >= fib_0_618 && priceInfo[0].open <= fib_1_000 && countPos<=2)
     {
      Print("Sell selll  " + count_100);
      //trade.PositionOpen(_Symbol,ORDER_TYPE_SELL,2,Bid,
      //                      (Bid - 126 * _Point),0);

      //trade.Sell(vol,NULL,Bid,0,(Bid - 126 * _Point),NULL);
     }
//else
//{trade.PositionClose(_Symbol,3);
//}

//Print("It is touched "+count_100);
   Print(" >>>>  "+ count_100 + ">>... "
//+ countArray[4] + " " + countArray[3]
        );



  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void storeAngleInfo(const int time1,const double price1,const int time0,const double price0)
  {
//This is the up Trend lines: long term
   ObjectCreate(_Symbol,"yooConst",OBJ_TREND,0,time0,price0,time1,price1);

   ObjectSetInteger(_Symbol,"yooConst",OBJPROP_COLOR,Red);
//ObjectSetInteger(_Symbol,"yooConst",OBJPROP_DEGREE,90);
   ObjectSetInteger(_Symbol,"yooConst",OBJPROP_RAY_LEFT,true);
   ObjectSetInteger(_Symbol,"yooConst",OBJPROP_RAY_RIGHT,true);
  }
//+------------------------------------------------------------------+
//| Checks which category it belongs and increments                  |
//+------------------------------------------------------------------+
void checkCategory(double angleLongUp)
  {
   if(angleLongUp> 10 && angleLongUp < 20)
     {
      angleVariation[0] +=1;
     }

   if(angleLongUp>20 && angleLongUp <30)
     {
      angleVariation[1] +=1;
     }

   if(angleLongUp>30 && angleLongUp <40)
     {
      angleVariation[2] +=1;
     }

   if(angleLongUp>40 && angleLongUp <50)
     {
      angleVariation[3] +=1;
     }

   if(angleLongUp>50 && angleLongUp <60)
     {
      angleVariation[4] +=1;
     }
   if(angleLongUp>60 && angleLongUp <70)
     {
      angleVariation[5] +=1;
     }
   if(angleLongUp>50 && angleLongUp <60)
     {
      angleVariation[6] +=1;
     }
   if(angleLongUp>70 && angleLongUp <80)
     {
      angleVariation[7] +=1;
     }
   if(angleLongUp>80 && angleLongUp <90)
     {
      angleVariation[8] +=1;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getPrice_Pixel_Conversion(double price)
  {
   double Max_Min_CHART, ratio_pixel_priceY, resultPix_PriceY,  resultPix_BarsX;
   if(ChartGetDouble(_Symbol,CHART_PRICE_MAX,0) == ChartGetDouble(_Symbol,CHART_PRICE_MIN,0))
     {
      //Max_Min_CHART = 0;
      ratio_pixel_priceY = 0;
     }
   else
     {
      Max_Min_CHART = ChartGetDouble(_Symbol,CHART_PRICE_MAX,0) - ChartGetDouble(_Symbol,CHART_PRICE_MIN,0);
      ratio_pixel_priceY = 106/Max_Min_CHART;
     }


   resultPix_PriceY = ((ChartGetDouble(_Symbol,CHART_PRICE_MAX,0) - price)*ratio_pixel_priceY);
   Print(resultPix_PriceY +" pixels Y coord..");
   return resultPix_PriceY;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double getTime_Pixel_Conversion(int LowestCand)
  {
   double Max_Min_CHART, ratio_pixel_priceY, resultPix_PriceY,  resultPix_BarsX;
   double ratio_Bars_Pixel;

   if(ChartGetInteger(0,CHART_VISIBLE_BARS,0)==0)
     {
      ratio_Bars_Pixel = 0;
     }
   else
     {
      ratio_Bars_Pixel = (double)107/(double)ChartGetInteger(0,CHART_VISIBLE_BARS,0);
     }
//Print("visible bars# "+ChartGetInteger(0,CHART_VISIBLE_BARS,0) +"lowestCand" + LowestCand + "ratio bars -pixels " + ratio_Bars_Pixel);

   resultPix_BarsX = (ChartGetInteger(0,CHART_VISIBLE_BARS,0) - LowestCand) * ratio_Bars_Pixel;
//Print(resultPix_BarsX +" pixels IN X coordinate");
   return resultPix_BarsX;
  }

//+------------------------------------------------------------------+
int optimizePeriod1(double slope)
  {
   int period  = slope/0.618;
   return period;

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int optimizePeriod2(double slope)
  {
   int period = slope/1.618;
   return period;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int countPositions()
  {
   int numOfBuyPosition = 0;

   for(int i = PositionsTotal()-1; i>=0 ; i--)
     {
      string currenyPair = PositionGetSymbol(i);
      int PositionDirection = PositionGetInteger(POSITION_TYPE);
      if(Symbol() == currenyPair)
         if(PositionDirection == POSITION_TYPE_BUY)
           {
            numOfBuyPosition  = numOfBuyPosition + 1;
           }
     }
   return numOfBuyPosition;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CheckNewBar()
  {
   MqlRates      current_rates[1];

   ResetLastError();
   if(CopyRates(Symbol(),Period(),0,1,current_rates)!=1)
     {
      Print("CopyRates copy error, Code = ",GetLastError());
      return(0);
     }

   if(current_rates[0].tick_volume>1)
     {
      return(0);
     }

   return(1);
  }
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   IndicatorRelease(movingAverageDef);
   IndicatorRelease(movingAverageDef2);
  }
//+------------------------------------------------------------------+
