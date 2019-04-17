import Foundation
import secp256k1

struct Example {

    typealias PublicKey = [UInt8]

    enum Error: Swift.Error {
        case invalidPublicKey
        case internalError
    }

    static func decompressPublicKey(_ pubkey: PublicKey) throws -> PublicKey {
        guard pubkey.count == 33,
            let firstByte = pubkey.first,
            firstByte == 2 || firstByte == 3 else {
            throw Error.invalidPublicKey
        }

        let context = secp256k1_context_create(UInt32(SECP256K1_CONTEXT_SIGN | SECP256K1_CONTEXT_VERIFY))!
        defer {
            secp256k1_context_destroy(context)
        }

        var cPubkey = secp256k1_pubkey()
        var uncompressedKeyLen = 65
        var uncompressedPubkey = [UInt8](repeating: 0, count: uncompressedKeyLen)
        guard secp256k1_ec_pubkey_parse(context, &cPubkey, pubkey, pubkey.count) == 1,
            secp256k1_ec_pubkey_serialize(context, &uncompressedPubkey, &uncompressedKeyLen, &cPubkey, UInt32(SECP256K1_EC_UNCOMPRESSED)) == 1 else {
            throw Error.internalError
        }

        return uncompressedPubkey
    }
}
