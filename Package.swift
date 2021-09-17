// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "secp256k1",
    platforms: [
        .macOS(.v10_13), .iOS(.v12)
    ],
    products: [
        .library(
            name: "secp256k1",
            targets: ["secp256k1"]
        ),
    ],
    targets: [
        .target(
            name: "libsecp256k1",
            path: "./secp256k1/Classes",
            exclude: [
                "secp256k1/build-aux",
                "secp256k1/sage",
                "secp256k1/src/asm",
                "secp256k1/src/testrand_impl.h",
                "secp256k1/src/testrand.h",
                "secp256k1/src/tests_exhaustive.c",
                "secp256k1/src/tests.c",
                "secp256k1/src/valgrind_ctime_test.c",
                "secp256k1/src/gen_context.c",
                "secp256k1/src/bench_ecdh.c",
                "secp256k1/src/bench_ecmult.c",
                "secp256k1/src/bench_internal.c",
                "secp256k1/src/bench_recover.c",
                "secp256k1/src/bench_sign.c",
                "secp256k1/src/bench_verify.c",
                "secp256k1/src/bench_schnorrsig.c",
                "secp256k1/src/bench.h",
                "secp256k1/src/modules/ecdh/tests_impl.h",
                "secp256k1/src/modules/ecdh/Makefile.am.include",
                "secp256k1/src/modules/recovery/tests_impl.h",
                "secp256k1/src/modules/recovery/tests_exhaustive_impl.h",
                "secp256k1/src/modules/recovery/Makefile.am.include",
                "secp256k1/src/modules/extrakeys/Makefile.am.include",
                "secp256k1/src/modules/schnorrsig/Makefile.am.include",
                "secp256k1/doc",
                "secp256k1/ci",
                "secp256k1/autogen.sh",
                "secp256k1/configure.ac",
                "secp256k1/COPYING",
                "secp256k1/libsecp256k1.pc.in",
                "secp256k1/Makefile.am",
                "secp256k1/README.md",
                "secp256k1/SECURITY.md",

                "exporter"
            ],
            sources: [
                ".",
                "secp256k1/src",
                "secp256k1/include",
                "secp256k1/contrib",
                "secp256k1/src/modules/ecdh",
                "secp256k1/src/modules/recovery"
            ],
            publicHeadersPath: "secp256k1/include",
            cSettings: [
                .define("HAVE_CONFIG_H"),
                .headerSearchPath("secp256k1"),
                .headerSearchPath("secp256k1/src"),
                .headerSearchPath(".")
            ]
        ),
        .target(
            name: "secp256k1",
            dependencies: ["libsecp256k1"],
            path: "./secp256k1/Classes/exporter",
            sources: ["."]
        )
    ]
)
