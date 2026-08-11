<?php

use WHMCS\Database\Capsule;

function verifyClientArea($vars) {
    $userId = $_SESSION['uid'] ?? null;
    $user = $userId ? Capsule::table('tblclients')->where('id', $userId)->first() : null;
    $email = $_POST['email'] ?? ($user->email ?? '');
    $message = '';

    if (isset($_POST['send_code'])) {
        $lastSent = $_SESSION['last_code_sent'] ?? 0;
        if (time() - $lastSent < 30) {
            $wait = 30 - (time() - $lastSent);
            $message = "<span style='color:red'>Please wait {$wait} seconds before resending.</span>";
        } else {
            $code = rand(100000, 999999);

            if ($userId) {
                Capsule::table('mod_email_verification')->updateOrInsert(
                    ['userid' => $userId],
                    ['email' => $email, 'code' => $code, 'verified' => 0, 'created_at' => Capsule::raw('CURRENT_TIMESTAMP')]
                );
            } else {
                $_SESSION['guest_email'] = $email;
                $_SESSION['guest_code'] = $code;
                $_SESSION['guest_verified'] = false;
            }

            sendVerificationCode($email, $code);
            $_SESSION['last_code_sent'] = time();
            $message = "<span style='color:green'>Verification code sent to $email</span>";
        }
    }

    if (isset($_POST['verify_code'])) {
        $inputCode = $_POST['code'];

        if ($userId) {
            $record = Capsule::table('mod_email_verification')->where('userid', $userId)->first();
            if ($record && $record->code == $inputCode) {
                Capsule::table('mod_email_verification')->where('userid', $userId)->update(['verified' => 1]);
                $message = "<span style='color:green'>Email verified successfully!</span>";
            } else {
                $message = "<span style='color:red'>Invalid code.</span>";
            }
        } else {
            if ($_SESSION['guest_code'] == $inputCode) {
                $_SESSION['guest_verified'] = true;
                $message = "<span style='color:green'>Email verified successfully!</span>";
            } else {
                $message = "<span style='color:red'>Invalid code.</span>";
            }
        }
    }

    return [
        'pagetitle' => 'Email Verification',
        'templatefile' => 'verify',
        'breadcrumb' => ['Email Verification'],
        'vars' => ['email' => $email, 'message' => $message]
    ];
}

function sendVerificationCode($email, $code) {
    $mail = new WHMCS\Mail\Template();
    $mail->load('EmailVerificationCode');
    $mail->setData(['verification_code' => $code, 'email' => $email]);
    $mail->send($email);
}
