// /// <summary>
// /// Report Direct Receipts report (ID 65815).
// /// </summary>
// report 65815 "Direct Receipts report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Reports/SSR/Direct Receipts report.rdl';

//     dataset
//     {
//         dataitem(Payment; 61717)
//         {
//             DataItemTableView = WHERE(Reversed = FILTER(No));
//             PrintOnlyIfDetail = false;
//             RequestFilterFields = Date, Type, "Account No.";
//             column(DateFilter; Payment.Date)
//             {
//             }
//             column(seq; seq)
//             {
//             }
//             column(StartDate; StartDate)
//             {
//             }
//             column(EndDate; EndDate)
//             {
//             }
//             column(MonthName; MonthName)
//             {
//             }
//             column(No; Payment.No)
//             {
//             }
//             column(PAyee; Payment."Received From")
//             {
//             }
//             column(Date; Payment.Date)
//             {
//             }
//             column(BankName; Payment."Cheque/Deposit Slip No")
//             {
//             }
//             column(checkno; Payment."Posted By")
//             {
//             }
//             column(ReleaseDate; Payment."Account No.")
//             {
//             }
//             column(Narration; Payment."Transaction Name")
//             {
//             }
//             column(NetAmount; Payment.Amount)
//             {
//             }
//             column(CompAddress; info.Address)
//             {
//             }
//             column(CompAddress1; info."Address 2")
//             {
//             }
//             column(CompPhonenO; info."Phone No.")
//             {
//             }
//             column(CompPhoneNo2; info."Phone No. 2")
//             {
//             }
//             column(CompPic; info.Picture)
//             {
//             }
//             column(CompEmail1; info."E-Mail")
//             {
//             }
//             column(CompHome; info."Home Page")
//             {
//             }
//             column(USER; USERID)
//             {
//             }
//             dataitem(DataItem4; Table61723)
//             {
//                 DataItemLink = No.=FIELD(No);
//                 RequestFilterFields = Cashier;
//                 column(CustName; "FIN-Receipts Header"."Received From")
//                 {
//                 }
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 seq := seq + 1;
//                 /*IntMonth:=DATE2DMY(SalesHeader."Posting Date",2);
//                 IF IntMonth<>0 THEN BEGIN
//                   IF IntMonth=1 THEN BEGIN
//                     MonthName:='JAN';
//                     END ELSE IF IntMonth=2 THEN BEGIN
//                       MonthName:='FEB';
//                       END  ELSE IF IntMonth=3 THEN BEGIN
//                         MonthName:='MAR';
//                       END  ELSE IF IntMonth=4 THEN BEGIN
//                         MonthName:='APRIL';
//                       END  ELSE IF IntMonth=5 THEN BEGIN
//                         MonthName:='MAY';
//                       END  ELSE IF IntMonth=6 THEN BEGIN
//                         MonthName:='JUNE';
//                       END  ELSE IF IntMonth=7 THEN BEGIN
//                         MonthName:='JULY';
//                       END  ELSE IF IntMonth=8 THEN BEGIN
//                         MonthName:='AUG';
//                       END  ELSE IF IntMonth=9 THEN BEGIN
//                         MonthName:='SEPT';
//                       END  ELSE IF IntMonth=10 THEN BEGIN
//                         MonthName:='OCT';
//                       END  ELSE IF IntMonth=11 THEN BEGIN
//                         MonthName:='NOV';
//                       END  ELSE IF IntMonth=12 THEN BEGIN
//                         MonthName:='DEC';
//                       END
//                   END;*/

//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         IF info.GET() THEN BEGIN
//             info.CALCFIELDS(Picture);
//         END;

//         CLEAR(seq);
//     end;

//     var
//         info: Record "79";
//         route: Code[20];
//         MonthName: Code[20];
//         IntMonth: Integer;
//         StartDate: Date;
//         EndDate: Date;
//         seq: Integer;
// }

