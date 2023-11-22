package kz.izsolve.iz_scan

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.util.Log
import com.getbouncer.cardscan.ui.CardScanActivity
import com.getbouncer.cardscan.ui.CardScanActivityResult
import com.getbouncer.cardscan.ui.CardScanActivityResultHandler
import io.flutter.embedding.android.FlutterActivity

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry


/** IzScanPlugin */
class IzScanPlugin: FlutterPlugin,  ActivityAware, MethodCallHandler, CardScanActivityResultHandler,PluginRegistry.ActivityResultListener
{
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var context: Context
  private lateinit var activity: Activity
  private lateinit var binaryMessenger: BinaryMessenger


  private val CHANNEL = "iz_scan"

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    Log.d("card_scan", "onAttachedToEngine  method")
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "iz_scan")
    channel.setMethodCallHandler(this)
    binaryMessenger = flutterPluginBinding.binaryMessenger
    context = flutterPluginBinding.applicationContext
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)

  }

  override fun onDetachedFromActivityForConfigChanges() {
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)

  }

  override fun onDetachedFromActivity() {
//    binding.removeActivityResultListener(this)

  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "configureCardScan" -> {
        result.success(null)
      }
      "startCardScan" -> {
        Log.d("card_scan", "startCardScan  method")
        CardScanActivity.warmUp(
          context = context,
          apiKey = "qOJ_fF-WLDMbG05iBq5wvwiTNTmM2qIn",
          initializeNameAndExpiryExtraction = true
        )

          CardScanActivity.start(
            activity = activity,
            apiKey = "qOJ_fF-WLDMbG05iBq5wvwiTNTmM2qIn",
            enableEnterCardManually = false,

            enableExpiryExtraction = false,

            enableNameExtraction = false
          )

      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
  override fun analyzerFailure(scanId: String?) {
    Log.d("card_scan", "analyzerFailure  method")
  }

  override fun cameraError(scanId: String?) {
    Log.d("card_scan", "cameraError  method")
  }

  override fun canceledUnknown(scanId: String?) {
    Log.d("card_scan", "canceledUnknown  method")
  }

  override fun cardScanned(scanId: String?, scanResult: CardScanActivityResult) {
    Log.d("card_scan", "cardScanned  method")
    val cardNumber = scanResult.pan
    val expiryDate = scanResult.expiryMonth
    val expiryYear = scanResult.expiryYear
    val cardholderName = scanResult.cardholderName
    Log.d("card_scan","cardNumber: $cardNumber")
    Log.d("card_scan","expiryMonth/expiryDate: $expiryDate/$expiryYear")
    Log.d("card_scan","cardholderName: $cardholderName")
    val resultMap = mapOf(
      "number" to scanResult.pan,
      "expiryMonth" to scanResult.expiryMonth,
      "expiryDate" to scanResult.expiryYear,
      "networkName" to scanResult.networkName,
      "cardholderName" to scanResult.cardholderName,
    ).mapValues { it.value?.toString() ?: "" }

//        setMethodChannelResult(resultMap)
    Log.d("card_scan","resultMap: $resultMap")


    val methodCall = MethodCall("cardScanned", resultMap)
    sendMethodCall(CHANNEL, methodCall)


  }

  override fun enterManually(scanId: String?) {
    Log.d("card_scan", "enterManually  method")
  }

  override fun userCanceled(scanId: String?) {
    Log.d("card_scan", "userCanceled  method")
  }

  // Utility function to send a MethodCall
  private fun sendMethodCall(channel: String, methodCall: MethodCall) {
    Log.d("card_scan", "sendMethodCall  methodCall: ${methodCall.method}")
    MethodChannel(binaryMessenger, channel)
      .invokeMethod(methodCall.method, methodCall.arguments)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (CardScanActivity.isScanResult(requestCode)) {
            CardScanActivity.parseScanResult(resultCode, data, this)
            return true
        }
        return false
    }

}

