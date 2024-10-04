// page 68007 "ACA-Council Members List"
// {
//     Caption = 'Council Members List';
//     CardPageID = 50009;
//     Editable = false;
//     PageType = List;
//     SourceTable = 23;
//     SourceTableView = WHERE("Vendor Posting Group" = CONST(COUNCIL));

//     layout
//     {
//         area(content)
//         {
//             repeater(general)
//             {
//                 field("No."; "No.")
//                 {
//                 }
//                 field(Name; Name)
//                 {
//                 }
//                 field(Picture; image)
//                 {
//                 }
//                 field("Post Code"; "Post Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Country/Region Code"; "Country/Region Code")
//                 {
//                     Visible = false;
//                 }
//                 field("Phone No."; "Phone No.")
//                 {
//                 }
//                 field("Fax No."; "Fax No.")
//                 {
//                     Visible = false;
//                 }
//                 field(Contact; Contact)
//                 {
//                 }
//                 field("Vendor Posting Group"; "Vendor Posting Group")
//                 {
//                     Visible = false;
//                 }
//                 field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
//                 {
//                     Visible = false;
//                 }
//                 field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
//                 {
//                     Visible = false;
//                 }
//                 field("Search Name"; "Search Name")
//                 {
//                 }
//                 field(Blocked; Blocked)
//                 {
//                     Visible = false;
//                 }
//                 field("Last Date Modified"; "Last Date Modified")
//                 {
//                     Visible = false;
//                 }
//                 field("Application Method"; "Application Method")
//                 {
//                     Visible = false;
//                 }
//             }
//         }
//         area(factboxes)
//         {
//             part("vendor FactB"; 9093)
//             {
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 Visible = false;
//             }
//             part("Vendor Statistics"; 9094)
//             {
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 Visible = true;
//             }
//             part("Vendor History"; 9095)
//             {
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 Visible = true;
//             }
//             part("Vendor Pay His"; 9096)
//             {
//                 SubPageLink = "No." = FIELD("No."),
//                               "Currency Filter" = FIELD("Currency Filter"),
//                               "Date Filter" = FIELD("Date Filter"),
//                               "Global Dimension 1 Filter" = FIELD("Global Dimension 1 Filter"),
//                               "Global Dimension 2 Filter" = FIELD("Global Dimension 2 Filter");
//                 Visible = false;
//             }
//             systempart(Links; Links)
//             {
//                 Visible = true;
//             }
//             systempart(Notes; Notes)
//             {
//                 Visible = true;
//             }
//         }
//     }

//     actions
//     {
//         area(navigation)
//         {
//             group("Ven&dor")
//             {
//                 Caption = 'Ven&dor';
//                 Image = Vendor;
//                 group(Dimensions)
//                 {
//                     Caption = 'Dimensions';
//                     Image = Dimensions;
//                     action("Dimensions-Single")
//                     {
//                         Caption = 'Dimensions-Single';
//                         Image = Dimensions;
//                         RunObject = Page 540;
//                         RunPageLink = "Table ID" = CONST(23),
//                                       "No." = FIELD("No.");
//                         ShortCutKey = 'Shift+Ctrl+D';
//                     }
//                     action("Dimensions-&Multiple")
//                     {
//                         Caption = 'Dimensions-&Multiple';
//                         Image = DimensionSets;

//                         trigger OnAction()
//                         var
//                             Vend: Record "23";
//                             DefaultDimMultiple: Page "Default Dimensions-Multiple";
//                         begin
//                             CurrPage.SETSELECTIONFILTER(Vend);
//                             DefaultDimMultiple.SetMultiVendor(Vend);
//                             DefaultDimMultiple.RUNMODAL;
//                         end;
//                     }
//                 }
//                 action("Bank Accounts")
//                 {
//                     Caption = 'Bank Accounts';
//                     Image = BankAccount;
//                     RunObject = Page "Vendor Bank Account List";
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                 }
//                 action("C&ontact")
//                 {
//                     Caption = 'C&ontact';
//                     Image = ContactPerson;

//                     trigger OnAction()
//                     begin
//                         ShowContact;
//                     end;
//                 }
//                 separator(___)
//                 {
//                 }
//                 action("Order &Addresses")
//                 {
//                     Caption = 'Order &Addresses';
//                     Image = Addresses;
//                     RunObject = Page 369;
//                     RunPageLink = "Vendor No." = FIELD("No.");
//                 }
//                 action("Co&mments")
//                 {
//                     Caption = 'Co&mments';
//                     Image = ViewComments;
//                     RunObject = Page 124;
//                     RunPageLink = "Table Name" = CONST(Vendor),
//                                   "No." = FIELD("No.");
//                 }
//                 action("Cross Re&ferences")
//                 {
//                     Caption = 'Cross Re&ferences';
//                     Image = Change;
//                     RunObject = Page 5723;
//                     RunPageLink = "Cross-Reference Type" = CONST(Vendor),
//                                   "Cross-Reference Type No." = FIELD("No.");
//                     RunPageView = SORTING("Cross-Reference Type", "Cross-Reference Type No.");
//                 }
//                 separator(______________)
//                 {
//                 }
//             }


//         }
//         area(creation)
//         {

//         }
//         area(processing)
//         {
//             action("Payment Journal")
//             {
//                 Caption = 'Payment Journal';
//                 Image = PaymentJournal;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 RunObject = Page 256;
//             }
//             action("Purchase Journal")
//             {
//                 Caption = 'Purchase Journal';
//                 Image = Journals;
//                 Promoted = false;
//                 //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
//                 //PromotedCategory = Process;
//                 RunObject = Page 254;
//             }
//         }

//     }

//     procedure GetSelectionFilter(): Text
//     var
//         Vend: Record 23;
//         SelectionFilterManagement: Codeunit 46;
//     begin
//         CurrPage.SETSELECTIONFILTER(Vend);
//         EXIT(SelectionFilterManagement.GetSelectionFilterForVendor(Vend));
//     end;

//     procedure SetSelection(var Vend: Record 23)
//     begin
//         CurrPage.SETSELECTIONFILTER(Vend);
//     end;
// }

