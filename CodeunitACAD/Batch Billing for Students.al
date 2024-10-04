codeunit 61112 "Batch Billing students"
{
    trigger OnRun()
    begin
    end;

    var
        acaRegistration: Record "ACA-Course Registration";
        StudentPayments: Record "ACA-Std Payments";
        StudentCharges: Record "ACA-Std Charges";
        GenJnl: Record "Gen. Journal Line";
        Stages: Record "ACA-Programme Stages";
        Units: Record "ACA-Units/Subjects";
        ExamsByStage: Record "ACA-Exams";
        ExamsByUnit: Record "ACA-Exams By Units";
        Charges: Record "ACA-Charge";
        Receipt: Record "ACA-Receipt";
        ReceiptItems: Record "ACA-Receipt Items";
        GenSetUp: Record "ACA-General Set-Up";


    procedure PostStudentsBilling()
    begin
        //Billing
        GenJnl.RESET;
        GenJnl.SETRANGE("Journal Template Name", 'SALES');
        GenJnl.SETRANGE("Journal Batch Name", 'STUD PAY');
        GenJnl.DELETEALL;

        acaRegistration.Reset();




    end;



}