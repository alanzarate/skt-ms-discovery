package com.ucb.bo.sktmsdiscovery

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.boot.runApplication
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer

@SpringBootApplication
@EnableEurekaServer
class SktMsDiscoveryApplication

fun main(args: Array<String>) {
	runApplication<SktMsDiscoveryApplication>(*args)
}
