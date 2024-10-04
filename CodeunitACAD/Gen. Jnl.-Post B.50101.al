// /// <summary>
// /// Codeunit Gen. Jnl.-Post B (ID 50101).
// /// </summary>
// codeunit 50101 "Gen. Jnl.-Post B"
// {
//     TableNo = 81;

//     trigger OnRun()
//     begin
//         GenJnlLine.COPY(Rec);
//         Code;
//         Rec.COPY(GenJnlLine);
//     end;

//     var
//         Text000: Label 'cannot be filtered when posting recurring journals';
//         Text001: Label 'Do you want to post the journal lines?';
//         Text002: Label 'There is nothing to post.';
//         Text003: Label 'The journal lines were successfully posted.';
//         Text004: Label 'The journal lines were successfully posted. You are now in the %1 journal.';
//         GenJnlTemplate: Record 80;
//         GenJnlLine: Record 81;
//         GenJnlPostBatch: Codeunit 13;
//         TempJnlBatchName: Code[10];

//     local procedure "Code"()
//     begin
// #pragma warning disable AL0606
// #pragma warning restore AL0606
//         GenJnlTemplate.GET(GenJnlLine."Journal Template Name");
//         GenJnlTemplate.TESTFIELD("Force Posting Report", FALSE);
//         IF GenJnlTemplate.Recurring AND (GenJnlLine.GETFILTER("Posting Date") <> '') THEN
//             GenJnlLine.FIELDERROR("Posting Date", Text000);

//         //IF NOT CONFIRM(Text001,FALSE) THEN
//         //EXIT;

//         TempJnlBatchName := GenJnlLine."Journal Batch Name";

//         GenJnlPostBatch.RUN(GenJnlLine);

//         IF GenJnlLine."Line No." = 0 THEN
//             MESSAGE(Text002)
//         ELSE
//             /*
//               IF TempJnlBatchName = "Journal Batch Name" THEN
//                 MESSAGE(Text003)
//               ELSE
//                 MESSAGE(
//                   Text004,
//                   "Journal Batch Name");
//             */
//             IF NOT GenJnlLine.FIND('=><') OR (TempJnlBatchName <> GenJnlLine."Journal Batch Name") THEN BEGIN
//                 GenJnlLine.RESET;
//                 GenJnlLine.FILTERGROUP(2);
//                 GenJnlLine.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
//                 GenJnlLine.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
//                 GenJnlLine.FILTERGROUP(0);
//                 GenJnlLine."Line No." := 1;
//             END;

//     end;
// }

