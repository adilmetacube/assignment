/* eslint-disable no-console */
import { LightningElement, track} from 'lwc';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import FAX_FIELD from '@salesforce/schema/Contact.Fax';
import createContact from '@salesforce/apex/createContact.createContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateRecordWithFieldIntigrity extends LightningElement {

    @track fname = FIRSTNAME_FIELD;
    @track lname = LASTNAME_FIELD;
    @track email = EMAIL;
    @track phone = PHONE_FIELD;
    @track fax = FAX_FIELD;
    rec = {
        FirstName:this.fname,
        LastName : this.lname,
        Email : this.email,
        Phone : this.phone,
        Fax : this.fax
    }

    handleFnameChange(event) {
        this.rec.FirstName = event.target.value;
        console.log("Fname", this.rec.FirstName);
    }

    handleLnameChange(event) {
        this.rec.LastName = event.target.value;
        console.log("Lname", this.rec.LastName);
    }
    
    handleEmailChange(event) {
        this.rec.Email = event.target.value;
        console.log("Email", this.rec.Email);
    }
    
    handlePhnChange(event) {
        this.rec.Phone = event.target.value;
        console.log("Phone", this.rec.Phone);
    }

    handleFaxChange(event) {
        this.rec.Fax = event.target.value;
        console.log("fax", this.rec.Fax);
    }

    handleClick() {
        createContact({ contact : this.rec })
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    this.rec.Name = '';
                    this.rec.Email = '';
                    this.rec.Phone = '';
                    this.rec.Fax = '';
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Contact created',
                            variant: 'success',
                        }),
                    );
                }
                
                console.log(JSON.stringify(result));
                console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });
    }
}