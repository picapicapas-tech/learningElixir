defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    current_time = NaiveDateTime.to_time(datetime)
    Time.compare(current_time, ~T[12:00:00]) == :lt
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    seconds = days * 24 * 60 * 60
    new_date = NaiveDateTime.add(checkout_datetime, seconds)
    NaiveDateTime.to_date(new_date)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)
    difference = Date.diff(actual_return_date, planned_return_date) 
    if difference < 0, do: 0, else: difference
  end

  def monday?(datetime) do
    date = NaiveDateTime.to_date(datetime)
    Date.day_of_week(date) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    limit_date = return_date(datetime_from_string(checkout))
    return_date = datetime_from_string(return)
    days = days_late(limit_date, return_date)
    if monday?(return_date) do
      floor(days * rate * 0.5)
    else
      floor(days * rate)
    end
  end
end
