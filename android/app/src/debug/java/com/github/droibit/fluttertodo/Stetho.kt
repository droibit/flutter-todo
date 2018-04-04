package com.github.droibit.fluttertodo

import android.content.Context
import android.util.Log
import com.facebook.stetho.Stetho.DefaultDumperPluginsBuilder
import com.facebook.stetho.Stetho.DefaultInspectorModulesBuilder
import com.facebook.stetho.dumpapp.DumperPlugin
import com.facebook.stetho.inspector.database.DatabaseFilesProvider
import com.facebook.stetho.inspector.database.DefaultDatabaseConnectionProvider
import com.facebook.stetho.inspector.database.SqliteDatabaseDriver
import com.facebook.stetho.inspector.protocol.ChromeDevtoolsDomain
import io.flutter.util.PathUtils
import java.io.File
import java.io.FileFilter
import com.facebook.stetho.Stetho as FacebookStetho

object Stetho {

  private class Initializer(private val context: Context) : FacebookStetho.Initializer(context) {

    override fun getDumperPlugins(): MutableIterable<DumperPlugin> =
      DefaultDumperPluginsBuilder(context).finish()

    override fun getInspectorModules(): Iterable<ChromeDevtoolsDomain> =
      DefaultInspectorModulesBuilder(context)
          .provideDatabaseDriver(
              SqliteDatabaseDriver(
                  context,
                  FlutterDatabaseFilesProvider(context),
                  DefaultDatabaseConnectionProvider()
              )
          )
          .finish()
  }

  private class FlutterDatabaseFilesProvider(private val context: Context) : DatabaseFilesProvider {

    override fun getDatabaseFiles(): List<File> {
      val dataDirectory = PathUtils.getDataDirectory(context)
      return File(dataDirectory, "database")
          .listFiles(FileFilter {
            it.extension == "db"
          })
          .toList()
    }
  }

  fun initializeWithDefaults(context: Context) {
    FacebookStetho.initialize(Initializer(context))
  }
}