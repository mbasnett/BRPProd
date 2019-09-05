public class NewstarDealFinancialInfo {
    
    public Decimal BaseModelPrice {get; set;}
    public Decimal LotPrice {get; set;}
    public Decimal LotPremium {get; set;}
    public Decimal TotalOptionsAmount {get; set;}
    public Decimal TotalDiscountAmount {get; set;}
    public Decimal TotalTaxAmount {get; set;}
    public Decimal TotalTaxRebateAmount {get; set;}
    public Decimal TotalMortgageIncentive {get; set;}
    public Boolean TotalMortgageIncentiveIncluded {get; set;}
    public Decimal TotalActualSaleAmount {get; set;}
    public Decimal TotalProjectedOptionsAmount {get; set;}
    public Decimal TotalProjectedDiscountAmount {get; set;}
    public Decimal TotalProjectedTaxAmount {get; set;}
    public Decimal TotalProjectedTaxRebateAmount {get; set;}
    public Decimal TotalProjectedMortgageIncentive {get; set;}
    public Boolean TotalProjectedMortgageIncentiveIncluded {get; set;}
    public Decimal TotalProjectedSaleAmount {get; set;}
    public Decimal TotalScheduledDeposit {get; set;}
    public Decimal TotalReceivedDeposit {get; set;}
    public Decimal TotalDepositDue {get; set;}
    
    
    public NewstarDealFinancialInfo() {
        this.BaseModelPrice=0;
        this.LotPrice=0;
        this.LotPremium=0;
        this.TotalOptionsAmount=0;
        this.TotalDiscountAmount=0;
        this.TotalTaxAmount=0;
        this.TotalTaxRebateAmount=0;
        this.TotalMortgageIncentive=0;
        this.TotalMortgageIncentiveIncluded=false;
        this.TotalActualSaleAmount=0;
        this.TotalProjectedOptionsAmount=0;
        this.TotalProjectedDiscountAmount=0;
        this.TotalProjectedTaxAmount=0;
        this.TotalProjectedTaxRebateAmount=0;
        this.TotalProjectedMortgageIncentive=0;
        this.TotalProjectedMortgageIncentiveIncluded=false;
        this.TotalProjectedSaleAmount=0;
        this.TotalScheduledDeposit=0;
        this.TotalReceivedDeposit=0;
        this.TotalDepositDue=0;
    }
}