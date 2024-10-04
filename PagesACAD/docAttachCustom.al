page 52071 "Document Attachment Custom"
{
    PageType = Worksheet;
    ApplicationArea = All;
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
                field(Name; REC."File Name")
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
                        IF REC."Document Reference ID".HASVALUE THEN
                            REC.Export(TRUE)
                        ELSE BEGIN
                            FileName := FileManagement.BLOBImportWithFilter(TempBlob, ImportTxt, FileName, STRSUBSTNO(FileDialogTxt, FilterTxt), FilterTxt);

                            IF FileName <> '' THEN
                                REC.SaveAttachment(FromRecRef, FileName, TempBlob);
                            CurrPage.UPDATE(FALSE);
                        END;

                    end;
                }
                field("File Extension"; "File Extension")
                {
                }
                // field(Description; Description)
                // {
                //     ApplicationArea = all;
                // }
                field("File Type"; "File Type")
                {
                }
                field(User; User)
                {
                }
                field("Attached Date"; "Attached Date")
                {
                }
                field("Document Flow Purchase"; "Document Flow Purchase")
                {
                    Visible = false;
                }
                field("Document Flow Sales"; "Document Flow Sales")
                {
                    Visible = false;
                }

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
        "File Name" := SelectFileTxt;
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
        Reset();
        FromRecRef := RecRef;
        SetRange("Table ID", RecRef.Number);

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
            DATABASE::Resource,
            DATABASE::"G/L Account":

                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    SETRANGE("No.", RecNo);
                END;
        END;
        CASE RecRef.Number of
            Database::"ACA-Applic. Form Header":
                begin
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    SETRANGE("No.", RecNo);
                end;
        END;

        // CASE RecRef.NUMBER OF
        //     DATABASE::"Interest Rates":
        //         BEGIN
        //             FieldRef := RecRef.FIELD(21);
        //             RecNo := FieldRef.VALUE;
        //             SETRANGE("No.", RecNo);
        //         END;

        // END;
        // CASE RecRef.NUMBER OF
        //     DATABASE::"Registration Management":
        //         BEGIN
        //             FieldRef := RecRef.FIELD(1);
        //             RecNo := FieldRef.VALUE;
        //             SETRANGE("No.", RecNo);

        //             FlowFieldsEditable := FALSE;
        //         END;
        // END;
        // CASE RecRef.NUMBER OF
        //     DATABASE::Retension:
        //         BEGIN
        //             FieldRef := RecRef.FIELD(1);
        //             RecNo := FieldRef.VALUE;
        //             SETRANGE("No.", RecNo);

        //             FlowFieldsEditable := FALSE;
        //         END;
        // END;
        // CASE RecRef.NUMBER OF
        //     DATABASE::Variation:
        //         BEGIN
        //             FieldRef := RecRef.FIELD(1);
        //             RecNo := FieldRef.VALUE;
        //             SETRANGE("No.", RecNo);

        //             FlowFieldsEditable := FALSE;
        //         END;
        // END;
        // CASE RecRef.NUMBER OF
        //     DATABASE::GMP:
        //         BEGIN
        //             FieldRef := RecRef.FIELD(1);
        //             RecNo := FieldRef.VALUE;
        //             SETRANGE("No.", RecNo);

        //             FlowFieldsEditable := FALSE;
        //         END;
        // END;
        // CASE RecRef.NUMBER OF
        //     DATABASE::"Documents Notification":
        //         BEGIN
        //             FieldRef := RecRef.FIELD(1);
        //             RecNo := FieldRef.VALUE;
        //             SETRANGE("No.", RecNo);

        //             FlowFieldsEditable := FALSE;
        //         END;
        // END;
        CASE RecRef.NUMBER OF
            DATABASE::"Sales Header",
            DATABASE::"Sales Line",
            DATABASE::"Purchase Header",
            DATABASE::"Purchase Line":
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    DocType := FieldRef.VALUE;
                    SETRANGE("Document Type", DocType);

                    FieldRef := RecRef.FIELD(3);
                    RecNo := FieldRef.VALUE;
                    SETRANGE("No.", RecNo);

                    FlowFieldsEditable := FALSE;
                END;
        END;
        CASE RecRef.NUMBER OF
            DATABASE::"Sales Line",
            DATABASE::"Purchase Line":
                BEGIN
                    FieldRef := RecRef.FIELD(4);
                    LineNo := FieldRef.VALUE;
                    SETRANGE("Line No.", LineNo);
                END;
        END;
        CASE RecRef.NUMBER OF
            DATABASE::"Sales Invoice Header",
            DATABASE::"Sales Cr.Memo Header",
            DATABASE::"Purch. Inv. Header",
            DATABASE::"Purch. Cr. Memo Hdr.":
                BEGIN
                    FieldRef := RecRef.FIELD(3);
                    RecNo := FieldRef.VALUE;
                    SETRANGE("No.", RecNo);

                    FlowFieldsEditable := FALSE;
                END;
        END;
        CASE RecRef.NUMBER OF
            DATABASE::"Sales Invoice Line",
            DATABASE::"Sales Cr.Memo Line",
            DATABASE::"Purch. Inv. Line",
            DATABASE::"Purch. Cr. Memo Line":
                BEGIN
                    FieldRef := RecRef.FIELD(3);
                    RecNo := FieldRef.VALUE;
                    SETRANGE("No.", RecNo);

                    FieldRef := RecRef.FIELD(4);
                    LineNo := FieldRef.VALUE;
                    SETRANGE("Line No.", LineNo);

                    FlowFieldsEditable := FALSE;
                END;
        END;

        OnAfterOpenForRecRef(Rec, RecRef);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenForRecRef(DocumentAttachment: Record "Document Attachment"; RecRef: recordref)
    begin

    end;
}