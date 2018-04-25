// This assumes that $customerId has been set appropriately from session data
if (!isset($_POST['api_version']))
{
    exit(http_response_code(400));
}
try {
    $key = \Stripe\EphemeralKey::create(
      array("customer" => $customerId),
      array("stripe_version" => $_POST['api_version'])
    );
    header('Content-Type: application/json');
    exit(json_encode($key));
} catch (Exception $e) {
    exit(http_response_code(500));
}