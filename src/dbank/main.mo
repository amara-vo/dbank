import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue: Float = 300;

  // use the above to reset value, comment out as needed
  //currentValue := 300;

  stable var startTime = Time.now();
  //startTime := Time.now();
  //Debug.print(debug_show(startTime));

  let id = 1361360;

  //Debug.print(debug_show(currentValue));

  //Debug.print(debug_show(id));

  public func topUp(amount: Float) {
    currentValue += amount;
    //Debug.print(debug_show(currentValue));
  };

  public func withdraw(amount: Float) {
    let tempValue: Float = currentValue - amount;

    if (tempValue >= 0) {
      currentValue -= amount;
      //Debug.print(debug_show(currentValue));

    } else {
      Debug.print("Amount too large.");
    }

  };

  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {

    // calculate number of minutes that have elapsed
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;  // nanoseconds
    let timeElapsedS = timeElapsedNS / 1000000000; //convert nanoseconds to seconds
    let timeElapsedM = timeElapsedS / 60;          // convert seconds to minutes
    // utilizes compount interest formula
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedM));
    startTime := currentTime;

    Debug.print(debug_show(currentValue));
  };



  //topUp();
}