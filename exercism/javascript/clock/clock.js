const HOURS_PER_DAY = 24;
const MINUTES_PER_HOUR = 60;
const MINUTES_PER_DAY = HOURS_PER_DAY * MINUTES_PER_HOUR;

export class Clock {
  constructor(hours, minutes) {
    minutes = minutes || 0;
    this._setTotalMinutes(hours * MINUTES_PER_HOUR + minutes);
  }

  plus(minutes) {
    return this._setTotalMinutes(this.totalMinutes + minutes);
  }

  minus(minutes) {
    return this._setTotalMinutes(this.totalMinutes - minutes);
  }

  _setTotalMinutes(totalMinutes) {
    totalMinutes = totalMinutes % MINUTES_PER_DAY;
    if (totalMinutes < 0) {
      totalMinutes = MINUTES_PER_DAY + totalMinutes;
    }
    this.totalMinutes = totalMinutes;
    return this;
  }

  equals(clock) {
    return clock.totalMinutes === this.totalMinutes;
  }

  toString() {
    const { hours, minutes } = this._splitMinutesIntoHours();
    return `${this._padNum(hours)}:${this._padNum(minutes)}`;
  }

  _splitMinutesIntoHours() {
    const hours = Math.floor(this.totalMinutes / MINUTES_PER_HOUR);
    const minutes = this.totalMinutes % MINUTES_PER_HOUR;
    return { hours, minutes };
  }

  _padNum(num) {
    return num.toString().padStart(2, '0');
  }
}
