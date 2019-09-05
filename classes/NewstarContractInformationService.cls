/*
    Provides helper methods to access opportunity, customers, etc. data
    associated with contract and customer operations.
*/
public  class NewstarContractInformationService {
   
  /*
    Returns the opportunity object given the specified ID
    and includes the fields necessary for typical NEWSTAR integration scenarios.
  */ 
  public static Opportunity getOpportunity(Id opportunityId) {

       Opportunity opp=[SELECT 
            Id,
            Name, 
            StageName, 
            CloseDate,
            Marketing_Community__c,
            Sales_Office__c, 
            Subdivision__c, 
            Model__c, 
            Lot__c, 
            Lot_Hold_Expiry_Date__c,
            Home_Swing__c,
            Newstar_ID__c,
            Scenario_Name__c,
            Account.Id,
            Investment__c,
            Visit_Date__c,
            Total_Sale_Amount__c,
            
            Sales_Agent_Sales_Office_Relationship__c,
            Sales_Agent_Sales_Office_Relationship__r.Sales_Agent__c,

            Sales_Agent_Sales_Office_Relationship_2__c,
            Sales_Agent_Sales_Office_Relationship_2__r.Sales_Agent__c,

            Account.Name,
            Account.FirstName,
            Account.LastName,
            Account.PersonMailingAddress,
            Account.PersonEmail,
            Account.Phone,
            Account.PersonMobilePhone,
            Account.PersonHomePhone,
            
            Subdivision__r.Name,
            Subdivision__r.Newstar_ID__c,
            Subdivision__r.Sitemap_URL__c,
            
            Model__r.Name,
            Model__r.Newstar_ID__c,
            
            Lot__r.Name,
            Lot__r.Newstar_ID__c,
            
            Real_Estate_Agent__c,
            Real_Estate_Agent__r.Newstar_ID__c,
            
            RecordType.Name,

            Sales_Office__r.Supported_Contract_Flows__c
           
            FROM Opportunity 
            WHERE Id=: opportunityId
            LIMIT 1];
      
         return opp;
    }


    
    /*
        Returns a person account<->sales office junction object
        based on the sales office selected on the supplied opportunity
        and the person account as the opportunity's parent.
    */
    public static Sales_Office_Customer__c getCustomerSalesOfficeJunction(Opportunity opp) {

        Sales_Office_Customer__c customerSalesOfficeJunction=null;
        
        //get the junction object that represents an association between
        //the customer's person account object and a NEWSTAR Sales sales office object
        List<Sales_Office_Customer__c> junctions=
            [
                SELECT 
                Id, 
                Sales_Office__c,
                Account__c,
                Newstar_ID__c
                FROM 
                Sales_Office_Customer__c 
                WHERE 
                Account__c =: opp.Account.Id
                AND
                Sales_Office__c =: opp.Sales_Office__c
                LIMIT 1
            ];

        if(junctions.size()==0) {
            //junction object does not exist, a new junction object needs to be created

            customerSalesOfficeJunction=new Sales_Office_Customer__c();
            
            customerSalesOfficeJunction.Sales_Office__c=opp.Sales_Office__c;
            customerSalesOfficeJunction.Account__c=opp.Account.Id;
          
        }
        else {
            customerSalesOfficeJunction=junctions[0];
        }


        return customerSalesOfficeJunction;

    }



  

    /*
        Returns the sales agent assigned to the opportunity
        via the junction sales agent<->sales office entity.
    */
    public static Sales_Agent__c getSalesAgentFromOpportunity(Id salesAgentId) {

        if(salesAgentId==null){
            return null;
        }

        Sales_Agent__c salesAgent=[
            SELECT 
            Id,
            Name,
            Newstar_ID__c
            FROM Sales_Agent__c
            WHERE Id=: salesAgentId
        ];

        return salesAgent;
    }
    


    /*
        Returns a NEWSTAR State object based on the free-form address in the customer's person account.
    */
    public static Newstar_State__c getNewstarStateAndCountry(Address address) {

        String stateProvinceCode=address.StateCode.trim().toUpperCase();
        String countryName=address.Country.trim();

        List<Newstar_State__c> states=
        [
            SELECT
            Id,
            Name,
            Newstar_ID__c,
            Newstar_Country__r.Newstar_ID__c
            
            FROM
            Newstar_State__c
            WHERE
            Code__c=: stateProvinceCode
            AND
            Newstar_Country__r.Name=: countryName
            LIMIT 1
        ];

        if(states.size()!=1)
            return null;

        return states[0];
    }



    /*
        Returns the specified Person Account representing the customer
        together with a list of child junction objections used to list
        the sales offices the account is associated with in NEWSTAR Sales.
    */
    public static Account getCustomerWithSalesOffices(Id customerAccountId) {

        List<Account> accounts=[

            SELECT 
                Id, 
                Name, 
                FirstName, 
                LastName,
                PersonMailingAddress,
                PersonEmail,
                Phone,
                PersonMobilePhone,
                PersonHomePhone,
                (
                    SELECT 
                        Id, 
                        Name,
                        Newstar_ID__c,
                        Newstar_Sync_Status__c, 
                        Sales_Office__c, 
                        Sales_Office__r.Name
                    FROM 
                        Sales_Office_Accounts__r
                )
            FROM Account
            WHERE Id =: customerAccountId
        ] ;

        if(accounts.size()==1) {
            return accounts[0];
        }
        
        return null;
    }


    public static Cobuyer__c getCobuyer(Id cobuyerId) {

        List<Cobuyer__c> cobuyers=[

            SELECT
                Id,
                Name,
                First_Name__c,
                Last_Name__c,
                Home_Email__c,
                Work_Email__c,
                Home_Phone__c,
                Work_Phone__c,
                Mobile_Phone__c,
                Newstar_ID__c,
                Opportunity__r.Newstar_ID__c
            FROM
                Cobuyer__c
            WHERE
                Id =: cobuyerId

            LIMIT 1
        ];

        if(cobuyers.size()==1) {
            return cobuyers[0];
        }

        return null;

    }
}