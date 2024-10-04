page 86521 "ACA-APP Attachments"
{
    Caption = 'ACA APP Attachments';
    DeleteAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Attachments';
    SourceTable = "ACA-Applicants Attachments";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Document Description"; Rec."Document Description")
                {
                    ApplicationArea = all;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = all;
                    Caption = 'Attachment Imported';
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Attachments)
            {
                Caption = 'Attachments';
                action(Open)
                {
                    ApplicationArea = all;
                    Caption = 'Open';
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."APP No", Rec."Document Description") then begin
                            if InteractTemplLanguage.Get(DocLink."APP No", DocLink."Language Code (Default)", DocLink."Document Description") then
                                InteractTemplLanguage.OpenAttachment;
                        end;
                    end;
                }
                action(Create)
                {
                    ApplicationArea = all;
                    Caption = 'Create';
                    Ellipsis = true;
                    Image = Campaign;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."APP No", Rec."Document Description") then begin
                            if not InteractTemplLanguage.Get(DocLink."APP No", DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.Init;
                                InteractTemplLanguage."Interaction Template Code" := Rec."APP No";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := Rec."Document Description";
                            end;
                            InteractTemplLanguage.CreateAttachment;
                            CurrPage.Update;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.Modify;
                        end;
                    end;
                }
                action("Copy & From")
                {
                    ApplicationArea = all;
                    Caption = 'Copy & From';
                    Ellipsis = true;
                    Image = Copy;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."APP No", Rec."Document Description") then begin

                            if InteractTemplLanguage.Get(DocLink."APP No", DocLink."Language Code (Default)") then
                                InteractTemplLanguage.CopyFromAttachment;
                            CurrPage.Update;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.Modify;
                        end;
                    end;
                }
                action(Import)
                {
                    ApplicationArea = all;
                    Caption = 'Import';
                    Ellipsis = true;
                    Image = Import;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."APP No", Rec."Document Description") then begin
                            if not InteractTemplLanguage.Get(DocLink."APP No", DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.Init;
                                InteractTemplLanguage."Interaction Template Code" := Rec."APP No";
                                InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                                InteractTemplLanguage.Description := DocLink."Document Description";
                                InteractTemplLanguage.Insert;
                            end;
                            InteractTemplLanguage.ImportAttachment;
                            CurrPage.Update;
                            DocLink.Attachment := DocLink.Attachment::Yes;
                            DocLink.Modify;
                        end;
                    end;
                }
                action("E&xport")
                {
                    ApplicationArea = all;
                    Caption = 'E&xport';
                    Ellipsis = true;
                    Image = Export;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."APP No", Rec."Document Description") then begin
                            if InteractTemplLanguage.Get(DocLink."APP No", DocLink."Language Code (Default)") then
                                InteractTemplLanguage.ExportAttachment;
                        end;
                    end;
                }
                action(Remove)
                {
                    ApplicationArea = all;
                    Caption = 'Remove';
                    Ellipsis = true;
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(Rec."APP No", Rec."Document Description") then begin
                            if InteractTemplLanguage.Get(DocLink."APP No", DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.RemoveAttachment(true);
                                DocLink.Attachment := DocLink.Attachment::No;
                                DocLink.Modify;
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record "ACA-Applicants Attachments";

    procedure GetDocument() Document: Text[200]
    begin
        Document := Rec."Document Description";
    end;
}

