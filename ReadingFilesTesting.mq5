//+------------------------------------------------------------------+
//|                                          ReadingFilesTesting.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

int h;
int i = 0;
int str[3]= {7,52,20};
int arr[];
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
//File path: C:\Users\User\AppData\Roaming\MetaQuotes\Tester\D0E8209F77C8CF37AD8BF550E51FF075\Agent-127.0.0.1-3000\Files\
//C://Users//User//AppData//Roaming//MetaQuotes//Terminal//D0E8209F77C8CF37AD8BF550E51FF075//MQL5//Files//Data//

//h=FileOpen("test_3.txt",FILE_WRITE|FILE_READ|FILE_ANSI|FILE_TXT|FILE_COMMON);
//FileSeek(h,0,SEEK_END);
//if(h==INVALID_HANDLE)
//  {
//   Alert("Error opening file: "+GetLastError());
//   //return (INIT_FAILED);
//  }
//FileWriteArray(h,str);
//while(!FileIsEnding(h))
//  {
//   FileReadInteger(h);

//   i++;
//  }

//Alert("Number: "+i);
//FileClose(h);

//int handle=FileOpen("test_4.bin",FILE_READ|FILE_WRITE|FILE_BIN|FILE_COMMON);
//if(handle!=INVALID_HANDLE)
//  {
//   //--- write array data to the end of the file
//   FileSeek(handle,0,SEEK_END);
//   FileWriteArray(handle,str);
//   //--- close the file
//   FileClose(handle);
//  }
//else
//   Print("Failed to open the file, error ",GetLastError());

   int file_handle=FileOpen("test_4.bin",FILE_READ|FILE_BIN|FILE_COMMON);
   if(file_handle!=INVALID_HANDLE)
     {
      //--- read all data from the file to the array
      FileReadArray(file_handle,arr);
      //--- receive the array size
      int size=ArraySize(arr);
      //--- print data from the array
      for(int i=0; i<size; i++)
         Print("Date = ",arr[i]);
      Print("Total data = ",size);
      //--- close the file
      FileClose(file_handle);
     }
   else
      Print("File open failed, error ",GetLastError());

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
//|         Using |FILE_COMMON to each file_Handle  is the key        |
//+------------------------------------------------------------------+
void fileReading(string fileToRead)
  {
   int arr[];
   int file_handle=FileOpen(fileToRead,FILE_READ|FILE_BIN|FILE_COMMON);
   if(file_handle!=INVALID_HANDLE)
     {
      //--- read all data from the file to the array
      FileReadArray(file_handle,arr);
      //--- receive the array size
      int size=ArraySize(arr);
      //--- print data from the array
      for(int i=0; i<size; i++)
         Print("Date = ",arr[i]);
      Print("Total data = ",size);
      //--- close the file
      FileClose(file_handle);
     }
   else
      Print("File open failed, error ",GetLastError());
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---


  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ReadFileToAlert(string FileName)
  {
//int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_TXT);
   if(h==INVALID_HANDLE)
     {
      Alert("Error opening file");
      return;
     }
   Alert("=== Start ===");
   while(!FileIsEnding(h))
     {
      string str=FileReadString(h);
      Alert(str);
     }
   FileClose(h);
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
