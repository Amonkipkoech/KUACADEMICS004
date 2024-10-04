pageextension 60000 "Customer Card Ext." extends "Customer Card"
{
    layout{
        addafter("Customer Posting Group"){
            
                                              field("Student Type"; Rec."Student Type")
                                              {
                                                  ToolTip = 'Specifies the value of the Student Type field.';
                                                  ApplicationArea = All;
                                              }
        }
    }
}