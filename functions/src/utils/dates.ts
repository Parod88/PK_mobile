export function sameDay(d1: Date, d2: Date) {
  return (
    d1.getFullYear() === d2.getFullYear() &&
    d1.getMonth() === d2.getMonth() &&
    d1.getDate() === d2.getDate()
  );
}

export function isDateWithinRange(
  date: Date,
  range: { start: string; end: string }
): boolean {
  const today = new Date();
  today.setHours(0, 0, 0, 0);

  const inputDate = new Date(date);
  inputDate.setHours(0, 0, 0, 0);

  if (inputDate.getTime() !== today.getTime()) {
    return false;
  }

  const parseTime = (time: string): number => {
    const [hours, minutes] = time.split(".").map(Number);
    return hours * 60 + minutes;
  };

  const startMinutes = parseTime(range.start);
  const endMinutes = parseTime(range.end);

  const receivedMinutes = date.getHours() * 60 + date.getMinutes();

  return receivedMinutes >= startMinutes && receivedMinutes <= endMinutes;
}
