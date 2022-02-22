import { appConfig } from './../../../../../../am-ui/src/config';
import {Component, Input} from '@angular/core';
import {FormGroup} from '@angular/forms';

import {FormFieldBase} from './form-field-base';

@Component({
  selector: 'mp-form-field',
  templateUrl: './dynamic-form-field.component.html',
  styleUrls: ['./dynamic-form-field.component.scss'],
})
export class DynamicFormFieldComponent {
  @Input() formField!: FormFieldBase<string>;
  @Input() form!: FormGroup;
  @Input() errorMessages: any;
  @Input() appLanguage: string;

  public selectCounterValues = appConfig.selectCounterValues;

  get isValid() {
    return this.form.controls[this.formField.key].valid;
  }
}
