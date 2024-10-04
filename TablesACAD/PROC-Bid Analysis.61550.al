/// <summary>
/// Table PROC-Bid Analysis (ID 61550).
/// </summary>
// table 61550 "PROC-Bid Analysis"
// {

//     fields
//     {
//         field(1; "RFQ No."; Code[20])
//         {
//         }
//         field(2; "RFQ Line No."; Integer)
//         {
//         }
//         field(3; "Quote No."; Code[20])
//         {
//         }
//         field(4; "Vendor No."; Code[20])
//         {
//         }
//         field(5; "Item No."; Code[20])
//         {
//         }
//         field(6; Description; Text[100])
//         {
//         }
//         field(7; Quantity; Decimal)
//         {
//         }
//         field(8; "Unit Of Measure"; Code[20])
//         {
//         }
//         field(9; Amount; Decimal)
//         {
//         }
//         field(10; "Line Amount"; Decimal)
//         {
//         }
//         field(11; Total; Decimal)
//         {
//         }
//         field(12; "Last Direct Cost"; Decimal)
//         {
//             CalcFormula = Lookup(Item."Last Direct Cost" WHERE("No." = FIELD("Item No.")));
//             FieldClass = FlowField;
//         }
//         field(13; Remarks; Text[50])
//         {

//             trigger OnValidate()
//             begin
//                 PurchLine.RESET;
//                 PurchLine.SETRANGE(PurchLine."Document Type", PurchLine."Document Type"::Quote);
//                 PurchLine.SETRANGE(PurchLine."Document No.", "Quote No.");
//                 PurchLine.SETRANGE(PurchLine."Line No.", "RFQ Line No.");
//                 IF PurchLine.FINDSET THEN BEGIN
//                     // PurchLine."RFQ Remarks" := Remarks;
//                     PurchLine.MODIFY;
//                 END
//             end;
//         }
//     }

//     keys
//     {
//         key(Key1; "RFQ No.", "RFQ Line No.", "Quote No.", "Vendor No.")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Item No.")
//         {
//         }
//         key(Key3; "Vendor No.")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     var
//         PurchLine: Record 39;
// }

