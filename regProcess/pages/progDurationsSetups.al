// page 52057 "Programme Durations Setups"
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = "Program Durations Setup";

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("Duration Code"; Rec."Duration Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Duration; Rec.Duration)
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//         area(Factboxes)
//         {

//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction();
//                 begin

//                 end;
//             }
//         }
//     }
// }