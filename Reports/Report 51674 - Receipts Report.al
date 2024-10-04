// report 51674 "Receipts Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Reports/SSR/Receipts Report.rdl';

//     dataset
//     {
//         dataitem(DataItem1102755004; 61723)
//         {
//             RequestFilterFields = "No.";
//             column(HeaderNo; "FIN-Receipts Header"."No.")
//             {
//             }
//             column(HeaderDate; "FIN-Receipts Header".Date)
//             {
//             }
//             column(UserID; "FIN-Receipts Header".Cashier)
//             {
//             }
//             column(AcctName; AcctName)
//             {
//             }
//             column(RegNo; RegNo)
//             {
//             }
//             column(RecFrom; "FIN-Receipts Header"."Received From")
//             {
//             }
//             column(CheqNo; "FIN-Receipts Header"."Cheque No.")
//             {
//             }
//             column(AmountReceived; "FIN-Receipts Header"."Amount Recieved")
//             {
//             }
//             column(UserName; 'You were served by: ' + UserName)
//             {
//             }
//             column(pic; CompanyInfo.Picture)
//             {
//             }
//             column(log; CompanyInfo.Picture)
//             {
//             }
//             dataitem(DataItem1102755006; Table61717)
//             {
//                 DataItemLink = No = FIELD(No.);
//                 column(RecLineNo; "FIN-Receipt Line q"."Account No.")
//                 {
//                 }
//                 column(RecLineAcctName; "FIN-Receipt Line q"."Account Name")
//                 {
//                 }
//                 column(Amount; "FIN-Receipt Line q".Amount)
//                 {
//                 }
//                 column(TotalAmount; TotalAmount)
//                 {
//                 }
//                 column(NumberText_1_; NumberText[1])
//                 {
//                 }
//                 column(PayMode; "FIN-Receipt Line q"."Pay Mode")
//                 {
//                 }
//                 column(TRanName; "FIN-Receipt Line q"."Transaction Name")
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     TotalAmount := TotalAmount + "FIN-Receipt Line q".Amount;

//                     //CheckReport.InitTextVariable;
//                     //CheckReport.FormatNoText(NumberText,TotalAmount,'');
//                 end;
//             }

//             trigger OnAfterGetRecord()
//             begin
//                 TotalAmount := 0;

//                 CLEAR(UserName);
//                 usersTable.RESET;
//                 usersTable.SETRANGE(usersTable."User Name", "FIN-Receipts Header".Cashier);
//                 IF usersTable.FIND('-') THEN BEGIN
//                     IF usersTable."Full Name" <> '' THEN
//                         UserName := usersTable."Full Name"
//                     ELSE
//                         UserName := "FIN-Receipts Header".Cashier;
//                 END ELSE
//                     UserName := "FIN-Receipts Header".Cashier;
//                 //CheckReport.FormatNoText(NumberText,"Receipts Header"."Amount Recieved",'');

//                 CheckReport.InitTextVariable();
//                 CheckReport.FormatNoText2('', "FIN-Receipts Header"."Amount Recieved", '');
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

//     trigger OnPreReport()
//     begin
//         CompanyInfo.RESET;
//         IF CompanyInfo.FIND('-') THEN BEGIN
//             CompanyInfo.CALCFIELDS(Picture);
//         END;
//     end;

//     var
//         AcctName: Text[150];
//         RegNo: Code[30];
//         NumberText: array[2] of Text[1024];
//         CheckReport: Report "1401";
//         TotalAmount: Decimal;
//         UserName: Text[250];
//         usersTable: Record "2000000120";
//         CompanyInfo: Record "79";
//         FormatAddr: Codeunit "365";
// }

