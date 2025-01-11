page 40036 "MRP Attachments"
{
  
    PageType = Worksheet;
    ApplicationArea = All;
    Caption = 'Transport Attachments';
    UsageCategory = Administration;
    SourceTable = "Document Attachment";
    SourceTableView = sorting(ID, "Table ID");
    //
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec."File Name")
                {
                    trigger OnDrillDown()
                    var
                        TempBlob: Codeunit "Temp Blob";
                        FileManagement: Codeunit "File Management";
                        FileName: Text;
                        ImportTxt: label 'Attach a document.';
                        FileDialogTxt: TextConst ENU = 'Attachments (%1)|%1';
                        FilterTxt: TextConst ENU = '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*';

                    begin
                        IF Rec."Document Reference ID".HASVALUE THEN
                            Rec.Export(TRUE)
                        ELSE BEGIN
                            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, STRSUBSTNO(FileDialogTxt, FilterTxt), FilterTxt);

                            IF FileName <> '' THEN
                                Rec.SaveAttachment(FromRecRef, FileName, TempBlob);
                            CurrPage.UPDATE(FALSE);
                        END;

                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                }
                // field(Description; Description)
                // {
                //     ApplicationArea = all;
                // }
                field("File Type"; Rec."File Type")
                {
                }
                field(User; Rec.User)
                {
                }
                field("Attached Date"; Rec."Attached Date")
                {
                }
                field("Document Flow Purchase"; Rec."Document Flow Purchase")
                {
                    Visible = false;
                }
                field("Document Flow Sales"; Rec."Document Flow Sales")
                {
                    Visible = false;
                }
                // field("Documents Type"; Rec."Documents Type")
                // {

                // }
                // field("Documents Name"; Rec."Documents Name")
                // {

                // }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var

    begin
        Rec."File Name" := SelectFileTxt;
    end;

    var
        FromRecRef: RecordRef;
        GLAccount: Record "G/L Account";
        //InterestRate: Record "Interest Rates";
        SalesDocumentFlow: Boolean;
        PurchaseDocumentFlow: Boolean;
        FlowFieldsEditable: Boolean;

        Attachment: Page "Document Attachment Details";
        SelectFileTxt: TextConst ENU = 'Select File...';


    procedure OpenForRecReference(RecRef: RecordRef)

    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option;
        LineNo: Integer;

    begin
        Rec.Reset();
        FromRecRef := RecRef;
        Rec.SetRange("Table ID", RecRef.Number);

        IF RecRef.NUMBER = DATABASE::Item THEN BEGIN
            SalesDocumentFlow := TRUE;
            PurchaseDocumentFlow := TRUE;
        END;
        CASE RecRef.NUMBER OF
            DATABASE::Customer,
            DATABASE::"Sales Header",
            DATABASE::"Sales Line",
            DATABASE::"Sales Invoice Header",
            DATABASE::"Sales Invoice Line",
            DATABASE::"Sales Cr.Memo Header",
            DATABASE::"Sales Cr.Memo Line":
                SalesDocumentFlow := TRUE;
            DATABASE::Vendor,
            DATABASE::"Purchase Header",
            DATABASE::"Purchase Line",
            DATABASE::"Purch. Inv. Header",
            DATABASE::"Purch. Inv. Line",
            DATABASE::"Purch. Cr. Memo Hdr.",
            DATABASE::"Master Rotation Plan2",
            DATABASE::"Purch. Cr. Memo Line":
                PurchaseDocumentFlow := TRUE;

        END;

        CASE RecRef.NUMBER OF
            DATABASE::Customer,
            DATABASE::Vendor,
            DATABASE::Item,
            DATABASE::Employee,
            DATABASE::"Fixed Asset",
            DATABASE::Job,
             DATABASE::"Master Rotation Plan2",
            DATABASE::Resource,
            DATABASE::"G/L Account":

                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    Rec.SETRANGE("No.", RecNo);
                END;
        END;
        CASE RecRef.Number of
            Database::"HRM-Job Applications (B)":
                begin
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    Rec.SETRANGE("No.", RecNo);
                end;
        END;
        CASE RecRef.Number of
            Database::"Master Rotation Plan2":
                begin
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    Rec.SETRANGE("No.", RecNo);
                end;
        END;



        OnAfterOpenForRecRef(Rec, RecRef);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenForRecRef(DocumentAttachment: Record "Document Attachment"; RecRef: recordref)
    begin

    end;
}
