codeunit 86000 "Graduation Journals"
{
    var
        gownJournal: Record "Gown Issuance Ledger";

    procedure postGowns(No: Code[20]; stud: Code[20]; dateIssued: date)
    begin
        gownJournal.Init;
        gownJournal."Document No." := No;
        gownJournal."Entry No." := gownJournal.GetLastEntryNo() + 1;
        gownJournal."Posting Date" := dateIssued;
        gownJournal.studentNo := stud;
        gownJournal."Entry Type" := gownJournal."Entry Type"::"Negative Adjmt.";
        gownJournal."Posting Date" := dateIssued;
        gownJournal.Description := 'Gown Issuance to ' + stud;
        //gownJournal."Entry Type" := LeaveEntry."Entry Type"::Application;
        gownJournal."User ID" := UserId;
        gownJournal.Quantity := -1;
        gownJournal.Insert(true);
    end;
}
