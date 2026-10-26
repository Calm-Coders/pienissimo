trigger ScadenzaFatturaTrigger on Scadenza_Fattura__c(after update) {
  ScadenzaFatturaTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
}
