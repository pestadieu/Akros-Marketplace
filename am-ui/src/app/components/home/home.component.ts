import {Router} from '@angular/router';
import {TranslateService} from '@ngx-translate/core';
import {Component, OnDestroy, OnInit} from '@angular/core';
import {Subscription} from 'rxjs';

@Component({
  selector: 'mp-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit, OnDestroy {
  public appLanguage: string;
  public subscription: Subscription;

  /**
   * @description Component with the main screen of the appliction, which hosts the search webcomponent,
   *  as well as further information and button link to access ads creation page.
   * @constructor
   * @param {TranslateService} translate - use of translate service to detect language change
   */
  constructor(private translate: TranslateService, private router: Router) {}

  public navigateCreateAdd() {
    const navigationExtras = {
      state: {
        appLanguage: this.appLanguage,
      },
    };
    this.router.navigate(['create'], navigationExtras);
  }

  ngOnInit(): void {
    this.subscription = this.translate.onLangChange.subscribe(appLanguage => {
      this.appLanguage = appLanguage.lang;
    });
  }

  ngOnDestroy() {
    this.subscription.unsubscribe();
  }

  showResults(event: Event) {
    const topics = (event as CustomEvent).detail.topics;
    const navigationExtras = {
      state: {
        topics: topics,
        language: this.appLanguage,
      },
    };
    this.router.navigate(['search-results'], navigationExtras);
  }
}
