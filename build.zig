const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const c_flags = [_][]const u8{
        // ssl
        "-DLIBUS_NO_SSL",
        // "-DWITH_OPENSSL",
        // "-DWITH_WOLFSSL",
        // "-DWITH_BORINGSSL",
        // event loop
        // "-DWITH_IO_URING",
        // "-DWITH_LIBUV",
        // "-DWITH_ASIO",
        // "-DWITH_GCD",
        // sanitizer
        // "-DWITH_ASAN",
        // quic
        // "-DWITH_QUIC",
    };

    const upstream = b.dependency("upstream", .{});
    const src_path = upstream.path("src");
    const include_path = upstream.path("src");
    const examples_path = upstream.path("examples");

    // -------------------------------------------------------------------------

    const lib_usockets = b.addStaticLibrary(.{
        .name = "usockets",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib_usockets);

    lib_usockets.addIncludePath(include_path);
    lib_usockets.addCSourceFiles(.{
        .root = src_path,
        .flags = &c_flags,
        .files = &.{
            "bsd.c",
            "context.c",
            "crypto/openssl.c",
            "eventing/epoll_kqueue.c",
            "eventing/gcd.c",
            "eventing/libuv.c",
            "io_uring/io_context.c",
            "io_uring/io_loop.c",
            "io_uring/io_socket.c",
            "loop.c",
            "quic.c",
            "socket.c",
            "udp.c",
        },
    });
    lib_usockets.installHeadersDirectory(src_path, "", .{});

    // -------------------------------------------------------------------------

    const exe_echo_server = b.addExecutable(.{
        .name = "echo_server",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_echo_server);

    exe_echo_server.addIncludePath(include_path);
    exe_echo_server.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"echo_server.c"},
        .flags = &c_flags,
    });
    exe_echo_server.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_hammer_test = b.addExecutable(.{
        .name = "hammer_test",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_hammer_test);

    exe_hammer_test.addIncludePath(include_path);
    exe_hammer_test.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"hammer_test.c"},
        .flags = &c_flags,
    });
    exe_hammer_test.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_hammer_test_unix = b.addExecutable(.{
        .name = "hammer_test_unix",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_hammer_test_unix);

    exe_hammer_test_unix.addIncludePath(include_path);
    exe_hammer_test_unix.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"hammer_test_unix.c"},
        .flags = &c_flags,
    });
    exe_hammer_test_unix.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_http3_client = b.addExecutable(.{
        .name = "http3_client",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_http3_client);

    exe_http3_client.addIncludePath(include_path);
    exe_http3_client.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"http3_client.c"},
        .flags = &c_flags,
    });
    exe_http3_client.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_http3_server = b.addExecutable(.{
        .name = "http3_server",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_http3_server);

    exe_http3_server.addIncludePath(include_path);
    exe_http3_server.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"http3_server.c"},
        .flags = &c_flags,
    });
    exe_http3_server.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_http_load_test = b.addExecutable(.{
        .name = "http_load_test",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_http_load_test);

    exe_http_load_test.addIncludePath(include_path);
    exe_http_load_test.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"http_load_test.c"},
        .flags = &c_flags,
    });
    exe_http_load_test.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_http_server = b.addExecutable(.{
        .name = "http_server",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_http_server);

    exe_http_server.addIncludePath(include_path);
    exe_http_server.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"http_server.c"},
        .flags = &c_flags,
    });
    exe_http_server.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_peer_verify_test = b.addExecutable(.{
        .name = "peer_verify_test",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_peer_verify_test);

    exe_peer_verify_test.addIncludePath(include_path);
    exe_peer_verify_test.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"peer_verify_test.c"},
        .flags = &c_flags,
    });
    exe_peer_verify_test.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_tcp_load_test = b.addExecutable(.{
        .name = "tcp_load_test",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_tcp_load_test);

    exe_tcp_load_test.addIncludePath(include_path);
    exe_tcp_load_test.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"tcp_load_test.c"},
        .flags = &c_flags,
    });
    exe_tcp_load_test.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_tcp_server = b.addExecutable(.{
        .name = "tcp_server",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_tcp_server);

    exe_tcp_server.addIncludePath(include_path);
    exe_tcp_server.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"tcp_server.c"},
        .flags = &c_flags,
    });
    exe_tcp_server.linkLibrary(lib_usockets);

    // -------------------------------------------------------------------------

    const exe_udp_benchmark = b.addExecutable(.{
        .name = "udp_benchmark",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe_udp_benchmark);

    exe_udp_benchmark.addIncludePath(include_path);
    exe_udp_benchmark.addCSourceFiles(.{
        .root = examples_path,
        .files = &.{"udp_benchmark.c"},
        .flags = &c_flags,
    });
    exe_udp_benchmark.linkLibrary(lib_usockets);
}
